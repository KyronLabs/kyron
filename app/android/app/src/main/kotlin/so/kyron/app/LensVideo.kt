package so.kyron.app

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.opengl.GLES20
import android.os.Handler
import android.os.Looper
import androidx.annotation.OptIn
import androidx.media3.common.Effect
import androidx.media3.common.MediaItem
import androidx.media3.common.MimeTypes
import androidx.media3.common.VideoFrameProcessingException
import androidx.media3.common.util.GlProgram
import androidx.media3.common.util.GlUtil
import androidx.media3.common.util.Size
import androidx.media3.common.util.UnstableApi
import androidx.media3.effect.BaseGlShaderProgram
import androidx.media3.effect.Crop
import androidx.media3.effect.GlEffect
import androidx.media3.effect.GlShaderProgram
import androidx.media3.effect.ScaleAndRotateTransformation
import androidx.media3.transformer.Composition
import androidx.media3.transformer.EditedMediaItem
import androidx.media3.transformer.Effects
import androidx.media3.transformer.ExportException
import androidx.media3.transformer.ExportResult
import androidx.media3.transformer.Transformer
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * Puts a lens into a recorded video, on the phone's GPU and its own encoder.
 *
 * The Dart side (lib/services/lens_video.dart) has already drawn what the lens
 * draws -- glasses, pictures, a fill's skin -- as one picture per moment of the
 * clip, and a mask per moment for the parts an effect blurs. This lays them
 * into the video with Media3 Transformer: one shader for the colour, the blur
 * and the drawings, then Media3's own crop and mirror. Audio is passed through
 * untouched.
 *
 * This replaced FFmpegKit, which did the same through a filter graph and
 * added 15 MB to every APK. Transformer is AndroidX and the app already ships
 * its player for video_player; the shader is the only new code that runs.
 */
@OptIn(UnstableApi::class)
class LensVideo(private val context: Context, messenger: BinaryMessenger) {
    private val main = Handler(Looper.getMainLooper())

    init {
        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method != "bake") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            val args = call.arguments as? Map<*, *>
            if (args == null) {
                result.error("bad-args", "Expected a map.", null)
                return@setMethodCallHandler
            }
            try {
                bake(Job.from(args), result)
            } catch (error: Exception) {
                result.error("bad-args", error.message, null)
            }
        }
    }

    /** One bake, as the Dart side described it. */
    data class Job(
        val input: String,
        val output: String,
        /** Flutter's 4x5 colour matrix, or null for none. */
        val matrix: FloatArray?,
        /** Each picture and the time, in microseconds, it takes over. */
        val overlays: List<Pair<Long, String>>,
        val masks: List<Pair<Long, String>>,
        /** Blur spread as a share of the frame's width. */
        val blur: Float,
        /** Frost's wash, as a 4x5 matrix, or null. */
        val wash: FloatArray?,
        /** The visible part of the frame, as fractions of it. */
        val crop: FloatArray,
        val mirror: Boolean,
    ) {
        companion object {
            fun from(args: Map<*, *>): Job {
                fun floats(key: String): FloatArray? =
                    (args[key] as? List<*>)?.map { (it as Number).toFloat() }?.toFloatArray()

                fun timeline(key: String): List<Pair<Long, String>> =
                    (args[key] as? List<*>).orEmpty().map {
                        val entry = it as Map<*, *>
                        (entry["at"] as Number).toLong() to (entry["path"] as String)
                    }

                return Job(
                    input = args["input"] as String,
                    output = args["output"] as String,
                    matrix = floats("matrix")?.also { require(it.size == 20) },
                    overlays = timeline("overlays"),
                    masks = timeline("masks"),
                    blur = (args["blur"] as? Number)?.toFloat() ?: 0f,
                    wash = floats("wash")?.also { require(it.size == 20) },
                    crop = floats("crop")?.also { require(it.size == 4) }
                        ?: floatArrayOf(0f, 0f, 1f, 1f),
                    mirror = args["mirror"] == true,
                )
            }
        }
    }

    private fun bake(job: Job, result: MethodChannel.Result) {
        val effects = mutableListOf<Effect>()
        if (job.matrix != null || job.overlays.isNotEmpty() || job.masks.isNotEmpty()) {
            effects += LensEffect(job)
        }
        val (left, top, width, height) = job.crop.toList()
        if (left > 0f || top > 0f || width < 1f || height < 1f) {
            // Normalised device coordinates: -1..1, y up.
            effects += Crop(
                -1f + 2f * left,
                -1f + 2f * (left + width),
                1f - 2f * (top + height),
                1f - 2f * top,
            )
        }
        if (job.mirror) {
            effects += ScaleAndRotateTransformation.Builder().setScale(-1f, 1f).build()
        }

        val item = EditedMediaItem.Builder(MediaItem.fromUri(android.net.Uri.fromFile(File(job.input))))
            .setEffects(Effects(emptyList(), effects))
            .build()

        // Transformer wants the thread it was built on to have a Looper, and
        // calls back on it. The main thread has one, and the work itself runs
        // on Transformer's own threads.
        main.post {
            var answered = false
            fun answer(block: () -> Unit) {
                if (answered) return
                answered = true
                block()
            }
            try {
                Transformer.Builder(context)
                    .setVideoMimeType(MimeTypes.VIDEO_H264)
                    .addListener(object : Transformer.Listener {
                        override fun onCompleted(composition: Composition, exportResult: ExportResult) {
                            answer { result.success(job.output) }
                        }

                        override fun onError(
                            composition: Composition,
                            exportResult: ExportResult,
                            exportException: ExportException,
                        ) {
                            answer {
                                result.error(
                                    "export-failed",
                                    "${exportException.errorCodeName}: ${exportException.message}",
                                    null,
                                )
                            }
                        }
                    })
                    .build()
                    .start(item, job.output)
            } catch (error: Exception) {
                answer { result.error("export-failed", error.message, null) }
            }
        }
    }

    companion object {
        const val CHANNEL = "so.kyron.app/lens_video"
    }
}

/** The lens, as a Media3 effect. */
@OptIn(UnstableApi::class)
private class LensEffect(private val job: LensVideo.Job) : GlEffect {
    override fun toGlShaderProgram(context: Context, useHdr: Boolean): GlShaderProgram =
        LensShaderProgram(job)
}

/**
 * Colour, blur through the mask, and the drawings, in one pass.
 *
 * The same order the preview stacks them in, and the photo is baked in: the
 * colour matrix first, then the blurred and washed picture wherever the mask
 * is white, then the drawn layer over everything.
 *
 * The blur is a 32-tap Gaussian-weighted disc, not two separable passes. It
 * only runs where the mask is non-zero, it is one program rather than three,
 * and frost is meant to be soft: a sampling pattern is invisible in it.
 */
@OptIn(UnstableApi::class)
private class LensShaderProgram(private val job: LensVideo.Job) :
    BaseGlShaderProgram(/* useHighPrecisionColorComponents= */ false, /* texturePoolCapacity= */ 1) {

    private val program = try {
        GlProgram(VERTEX, FRAGMENT)
    } catch (error: GlUtil.GlException) {
        throw VideoFrameProcessingException(error)
    }

    private val art = Layer(job.overlays)
    private val mask = Layer(job.masks)
    private var aspect = 1f

    init {
        program.setBufferAttribute(
            "aFramePosition",
            GlUtil.getNormalizedCoordinateBounds(),
            GlUtil.HOMOGENEOUS_COORDINATE_VECTOR_SIZE,
        )
        val (colour, offset) = split(job.matrix ?: IDENTITY)
        program.setFloatsUniform("uColour", colour)
        program.setFloatsUniform("uColourOffset", offset)
        val (wash, washOffset) = split(job.wash ?: IDENTITY)
        program.setFloatsUniform("uWash", wash)
        program.setFloatsUniform("uWashOffset", washOffset)
        // Disc radius of 2.5 sigma: past that the weights are negligible.
        program.setFloatUniform("uBlur", job.blur * 2.5f)
    }

    override fun configure(inputWidth: Int, inputHeight: Int): Size {
        aspect = inputWidth.toFloat() / inputHeight.toFloat()
        return Size(inputWidth, inputHeight)
    }

    override fun drawFrame(inputTexId: Int, presentationTimeUs: Long) {
        try {
            program.use()
            program.setSamplerTexIdUniform("uTexSampler", inputTexId, 0)
            val maskTex = mask.textureAt(presentationTimeUs)
            val artTex = art.textureAt(presentationTimeUs)
            program.setFloatUniform("uUseMask", if (maskTex != null && job.blur > 0f) 1f else 0f)
            program.setFloatUniform("uUseArt", if (artTex != null) 1f else 0f)
            // A sampler must point somewhere even when unused.
            program.setSamplerTexIdUniform("uMask", maskTex ?: inputTexId, 1)
            program.setSamplerTexIdUniform("uArt", artTex ?: inputTexId, 2)
            program.setFloatUniform("uAspect", aspect)
            program.bindAttributesAndUniforms()
            GLES20.glDrawArrays(GLES20.GL_TRIANGLE_STRIP, 0, 4)
        } catch (error: GlUtil.GlException) {
            throw VideoFrameProcessingException(error, presentationTimeUs)
        }
    }

    override fun release() {
        super.release()
        try {
            art.release()
            mask.release()
            program.delete()
        } catch (error: GlUtil.GlException) {
            throw VideoFrameProcessingException(error)
        }
    }

    /**
     * A timed sequence of pictures, uploaded to the GPU one at a time as the
     * video reaches each. Only the current one is kept: a minute at fifteen a
     * second would otherwise be 900 textures.
     */
    private class Layer(private val frames: List<Pair<Long, String>>) {
        private var index = -1
        private var texture = -1

        fun textureAt(timeUs: Long): Int? {
            if (frames.isEmpty()) return null
            var wanted = -1
            // Sorted by time; the last one that has started is the one on.
            for (i in frames.indices) {
                if (frames[i].first <= timeUs) wanted = i else break
            }
            if (wanted < 0) return null
            if (wanted != index) {
                if (texture != -1) GlUtil.deleteTexture(texture)
                texture = -1
                index = wanted
                val bitmap: Bitmap? = BitmapFactory.decodeFile(frames[wanted].second)
                if (bitmap != null) {
                    texture = GlUtil.createTexture(bitmap)
                    bitmap.recycle()
                }
            }
            return if (texture == -1) null else texture
        }

        fun release() {
            if (texture != -1) GlUtil.deleteTexture(texture)
            texture = -1
        }
    }

    companion object {
        private val IDENTITY = floatArrayOf(
            1f, 0f, 0f, 0f, 0f,
            0f, 1f, 0f, 0f, 0f,
            0f, 0f, 1f, 0f, 0f,
            0f, 0f, 0f, 1f, 0f,
        )

        /**
         * Flutter's row-major 4x5 matrix as a column-major GL mat4 of the RGB
         * coefficients, and the offsets on their own in 0-1.
         */
        fun split(m: FloatArray): Pair<FloatArray, FloatArray> {
            val mat = FloatArray(16)
            for (row in 0 until 4) {
                for (col in 0 until 4) {
                    mat[col * 4 + row] = m[row * 5 + col]
                }
            }
            val offset = floatArrayOf(m[4] / 255f, m[9] / 255f, m[14] / 255f, 0f)
            return mat to offset
        }

        const val VERTEX = """
attribute vec4 aFramePosition;
varying vec2 vTexSamplingCoord;
void main() {
  gl_Position = aFramePosition;
  vTexSamplingCoord = aFramePosition.xy * 0.5 + 0.5;
}
"""

        // Video frames have their origin at the bottom left; a bitmap
        // uploaded to a texture has its first row at the bottom. So the mask
        // and the drawings are sampled upside down relative to the frame --
        // the same flip Media3's own BitmapOverlay applies.
        const val FRAGMENT = """
precision mediump float;
uniform sampler2D uTexSampler;
uniform sampler2D uMask;
uniform sampler2D uArt;
uniform mat4 uColour;
uniform vec4 uColourOffset;
uniform mat4 uWash;
uniform vec4 uWashOffset;
uniform float uBlur;
uniform float uAspect;
uniform float uUseMask;
uniform float uUseArt;
varying vec2 vTexSamplingCoord;

vec3 grade(vec3 c) {
  return clamp((uColour * vec4(c, 1.0)).rgb + uColourOffset.rgb, 0.0, 1.0);
}

void main() {
  vec2 uv = vTexSamplingCoord;
  vec2 upright = vec2(uv.x, 1.0 - uv.y);
  vec3 colour = grade(texture2D(uTexSampler, uv).rgb);

  if (uUseMask > 0.5) {
    float m = texture2D(uMask, upright).r;
    if (m > 0.004) {
      vec3 sum = vec3(0.0);
      float total = 0.0;
      for (int i = 0; i < 32; i++) {
        float f = float(i);
        float r = sqrt((f + 0.5) / 32.0);
        float a = f * 2.39996323;
        vec2 o = vec2(cos(a), sin(a) * uAspect) * r * uBlur;
        float w = exp(-3.125 * r * r);
        sum += grade(texture2D(uTexSampler, uv + o).rgb) * w;
        total += w;
      }
      vec3 soft = sum / total;
      soft = clamp((uWash * vec4(soft, 1.0)).rgb + uWashOffset.rgb, 0.0, 1.0);
      colour = mix(colour, soft, m);
    }
  }

  if (uUseArt > 0.5) {
    // Android bitmaps are premultiplied, and upload that way.
    vec4 a = texture2D(uArt, upright);
    colour = a.rgb + colour * (1.0 - a.a);
  }

  gl_FragColor = vec4(colour, 1.0);
}
"""
    }
}
