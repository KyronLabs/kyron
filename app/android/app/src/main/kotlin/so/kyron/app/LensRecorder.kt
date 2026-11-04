package so.kyron.app

import android.media.Image
import android.media.MediaCodec
import android.media.MediaCodecInfo
import android.media.MediaFormat
import android.media.MediaMuxer
import android.os.Handler
import android.os.HandlerThread
import android.os.Looper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/**
 * Records a lens video from the frames the face is tracked in.
 *
 * Why not the camera's own recording: a lens recording needs the camera's
 * frames while it records, to track the face, and on many phones CameraX
 * cannot run video and those frames at once. It merges the preview and the
 * video into one shared stream, which arrives already rotated, and the
 * camera plugin turns the preview on its side. Preview plus frames -- what
 * the screen runs before recording -- works everywhere, so a lens recording
 * keeps exactly that and encodes the frames here, on the phone's own
 * hardware encoder. The sound is recorded separately and laid in when the
 * lens is (LensVideo.kt).
 *
 * The frames are NV21, as the plugin hands them to Dart, in the sensor's own
 * orientation; the file carries that rotation as a hint, as the camera's own
 * recordings do. Each frame is stamped with the same clock the lens timeline
 * is, so the lens lands on the frame it was tracked in.
 */
class LensRecorder(messenger: BinaryMessenger) {
    private val main = Handler(Looper.getMainLooper())
    private var session: Session? = null

    init {
        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            val args = call.arguments as? Map<*, *>
            when (call.method) {
                "start" -> {
                    session?.abandon()
                    session = null
                    val width = (args?.get("width") as? Number)?.toInt() ?: 0
                    val height = (args?.get("height") as? Number)?.toInt() ?: 0
                    // Checked before anything is created: an encoder and an
                    // open file are not to be left behind by a bad request.
                    if (width <= 0 || height <= 0 || width % 2 != 0 || height % 2 != 0) {
                        result.error("bad-size", "Frames must have even sides: $width x $height", null)
                        return@setMethodCallHandler
                    }
                    try {
                        session = Session(
                            path = args!!["path"] as String,
                            width = width,
                            height = height,
                            rotation = (args["rotation"] as Number).toInt(),
                        )
                        result.success(null)
                    } catch (error: Exception) {
                        result.error("start-failed", error.message, null)
                    }
                }
                "frame" -> {
                    val current = session
                    if (current == null || args == null) {
                        result.success(false)
                        return@setMethodCallHandler
                    }
                    val bytes = args["bytes"] as ByteArray
                    val stride = (args["stride"] as Number).toInt()
                    val pts = (args["pts"] as Number).toLong()
                    // Off the main thread, and answered when done, so Dart
                    // sends the next frame only once this one is in: a
                    // backlog would grow without end on a slow phone.
                    current.post {
                        val taken = current.encode(bytes, stride, pts)
                        main.post { result.success(taken) }
                    }
                }
                "stop" -> {
                    val current = session
                    session = null
                    if (current == null) {
                        result.error("not-recording", "Nothing is being recorded.", null)
                        return@setMethodCallHandler
                    }
                    current.post {
                        val ok = current.finish()
                        main.post {
                            if (ok) {
                                result.success(current.path)
                            } else {
                                result.error("stop-failed", current.failure, null)
                            }
                        }
                    }
                }
                "cancel" -> {
                    session?.abandon()
                    session = null
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private class Session(
        val path: String,
        private val width: Int,
        private val height: Int,
        rotation: Int,
    ) {
        private val thread = HandlerThread("lens-recorder").apply { start() }
        private val handler = Handler(thread.looper)
        private val codec = MediaCodec.createEncoderByType(MediaFormat.MIMETYPE_VIDEO_AVC)
        private val muxer = MediaMuxer(path, MediaMuxer.OutputFormat.MUXER_OUTPUT_MPEG_4)
        private val info = MediaCodec.BufferInfo()
        private var track = -1
        private var muxing = false
        private var written = 0
        private var lastPts = -1L
        private var released = false
        var failure: String? = null
            private set

        init {
            val format = MediaFormat.createVideoFormat(
                MediaFormat.MIMETYPE_VIDEO_AVC,
                width,
                height,
            ).apply {
                // Flexible: whatever 4:2:0 layout this encoder wants, written
                // through its Image planes below.
                setInteger(
                    MediaFormat.KEY_COLOR_FORMAT,
                    MediaCodecInfo.CodecCapabilities.COLOR_FormatYUV420Flexible,
                )
                setInteger(
                    MediaFormat.KEY_BIT_RATE,
                    (width * height * 6).coerceIn(2_000_000, 12_000_000),
                )
                setInteger(MediaFormat.KEY_FRAME_RATE, 30)
                setInteger(MediaFormat.KEY_I_FRAME_INTERVAL, 1)
            }
            try {
                codec.configure(format, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE)
                codec.start()
                muxer.setOrientationHint(((rotation % 360) + 360) % 360)
            } catch (error: Exception) {
                release()
                throw error
            }
        }

        fun post(block: () -> Unit) {
            handler.post(block)
        }

        /** One frame in. False when it was dropped. */
        fun encode(nv21: ByteArray, stride: Int, ptsUs: Long): Boolean {
            if (released || failure != null) return false
            // Timestamps must only go forward, or the muxer refuses the file.
            if (ptsUs <= lastPts) return false
            return try {
                val index = codec.dequeueInputBuffer(10_000)
                if (index < 0) {
                    drain(endOfStream = false)
                    return false
                }
                val image = codec.getInputImage(index)
                if (image == null) {
                    codec.queueInputBuffer(index, 0, 0, ptsUs, 0)
                    failure = "The encoder gave no image to write into."
                    return false
                }
                writeNv21(nv21, stride, image)
                codec.queueInputBuffer(index, 0, width * height * 3 / 2, ptsUs, 0)
                lastPts = ptsUs
                drain(endOfStream = false)
                true
            } catch (error: Exception) {
                failure = "${error.javaClass.simpleName}: ${error.message}"
                false
            }
        }

        /**
         * NV21 -- a plane of luma, then interleaved V and U at half size, both
         * on the same row stride -- into whatever planes the encoder gave.
         */
        private fun writeNv21(nv21: ByteArray, stride: Int, image: Image) {
            val planes = image.planes
            val luma = planes[0]
            val yBuffer = luma.buffer
            for (row in 0 until height) {
                val from = row * stride
                val to = row * luma.rowStride
                if (luma.pixelStride == 1) {
                    yBuffer.position(to)
                    yBuffer.put(nv21, from, width)
                } else {
                    for (col in 0 until width) {
                        yBuffer.put(to + col * luma.pixelStride, nv21[from + col])
                    }
                }
            }
            val u = planes[1]
            val v = planes[2]
            val chroma = stride * height
            for (row in 0 until height / 2) {
                val from = chroma + row * stride
                for (col in 0 until width / 2) {
                    val at = from + col * 2
                    v.buffer.put(row * v.rowStride + col * v.pixelStride, nv21[at])
                    u.buffer.put(row * u.rowStride + col * u.pixelStride, nv21[at + 1])
                }
            }
        }

        private fun drain(endOfStream: Boolean) {
            var idle = 0
            while (true) {
                val out = codec.dequeueOutputBuffer(info, if (endOfStream) 10_000L else 0L)
                when {
                    out == MediaCodec.INFO_TRY_AGAIN_LATER -> {
                        // Waiting out the last frames at the end; otherwise
                        // nothing more is ready yet, which is fine.
                        if (!endOfStream || ++idle > 300) return
                    }
                    out == MediaCodec.INFO_OUTPUT_FORMAT_CHANGED -> {
                        if (!muxing) {
                            track = muxer.addTrack(codec.outputFormat)
                            muxer.start()
                            muxing = true
                        }
                    }
                    out >= 0 -> {
                        val buffer = codec.getOutputBuffer(out)
                        if (info.flags and MediaCodec.BUFFER_FLAG_CODEC_CONFIG != 0) {
                            // Already in the format the track was added with.
                            info.size = 0
                        }
                        if (buffer != null && info.size > 0 && muxing) {
                            buffer.position(info.offset)
                            buffer.limit(info.offset + info.size)
                            muxer.writeSampleData(track, buffer, info)
                            written++
                        }
                        codec.releaseOutputBuffer(out, false)
                        if (info.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM != 0) return
                    }
                }
            }
        }

        /** Ends the file. True when it holds at least one frame. */
        fun finish(): Boolean {
            return try {
                if (failure == null && !released) {
                    val index = codec.dequeueInputBuffer(100_000)
                    if (index >= 0) {
                        codec.queueInputBuffer(
                            index,
                            0,
                            0,
                            lastPts + 33_000,
                            MediaCodec.BUFFER_FLAG_END_OF_STREAM,
                        )
                    }
                    drain(endOfStream = true)
                }
                val ok = failure == null && muxing && written > 0
                if (!ok && failure == null) failure = "No frames were recorded."
                release()
                ok
            } catch (error: Exception) {
                failure = "${error.javaClass.simpleName}: ${error.message}"
                release()
                false
            }
        }

        fun abandon() {
            post { release() }
        }

        private fun release() {
            if (released) return
            released = true
            try {
                codec.stop()
            } catch (ignored: Exception) {
            }
            try {
                codec.release()
            } catch (ignored: Exception) {
            }
            try {
                if (muxing) muxer.stop()
            } catch (ignored: Exception) {
            }
            try {
                muxer.release()
            } catch (ignored: Exception) {
            }
            thread.quitSafely()
        }
    }

    companion object {
        const val CHANNEL = "so.kyron.app/lens_recorder"
    }
}
