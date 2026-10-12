package so.kyron.app

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * The app, plus one thing Flutter has no word for: being handed something by
 * another app's share sheet.
 *
 * A share arrives as an intent -- on [onCreate] when it starts the app, on
 * [onNewIntent] when the app was already running. Either way it is read into
 * plain values here and passed over [CHANNEL]: the text, and any pictures
 * copied into this app's cache. Copied because a shared picture is a
 * content:// address whose permission belongs to this activity and can lapse
 * once it moves on; a file in our own cache is ours to upload whenever the
 * person gets round to sending it.
 */
class MainActivity : FlutterActivity() {
    private var channel: MethodChannel? = null

    /** A share that arrived before Flutter asked for it. Taken once. */
    private var waiting: Map<String, Any?>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Not on a re-creation: the intent is the one already handled, and
        // offering it again would open the share sheet a second time.
        if (savedInstanceState == null) waiting = read(intent)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "take" -> {
                        result.success(waiting)
                        waiting = null
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val share = read(intent) ?: return
        val open = channel
        if (open == null) waiting = share else open.invokeMethod("shared", share)
    }

    /** What [intent] hands over, or null when it is not a share. */
    private fun read(intent: Intent?): Map<String, Any?>? {
        if (intent == null) return null
        val action = intent.action
        if (action != Intent.ACTION_SEND && action != Intent.ACTION_SEND_MULTIPLE) return null

        val text = intent.getStringExtra(Intent.EXTRA_TEXT)?.trim()
            ?: intent.getStringExtra(Intent.EXTRA_SUBJECT)?.trim()
        val files = streams(intent, action)
            .take(MAX_FILES)
            .mapNotNull { copy(it) }
        if (text.isNullOrEmpty() && files.isEmpty()) return null
        return mapOf("text" to text, "files" to files)
    }

    @Suppress("DEPRECATION")
    private fun streams(intent: Intent, action: String): List<Uri> =
        if (action == Intent.ACTION_SEND) {
            listOfNotNull(
                if (Build.VERSION.SDK_INT >= 33) {
                    intent.getParcelableExtra(Intent.EXTRA_STREAM, Uri::class.java)
                } else {
                    intent.getParcelableExtra(Intent.EXTRA_STREAM)
                },
            )
        } else {
            (
                if (Build.VERSION.SDK_INT >= 33) {
                    intent.getParcelableArrayListExtra(Intent.EXTRA_STREAM, Uri::class.java)
                } else {
                    intent.getParcelableArrayListExtra(Intent.EXTRA_STREAM)
                }
                ) ?: emptyList()
        }

    /**
     * [uri] copied into the cache, or null if it is not a picture or is too
     * large to be worth holding. Pictures only: a shared video can be
     * hundreds of megabytes, and copying it here would hold the share sheet
     * up for the length of the copy.
     */
    private fun copy(uri: Uri): String? = try {
        val type = contentResolver.getType(uri) ?: ""
        if (!type.startsWith("image/")) {
            null
        } else if (sizeOf(uri) > MAX_BYTES) {
            null
        } else {
            val folder = File(cacheDir, "shared").apply { mkdirs() }
            val extension = type.substringAfter('/').substringBefore('+').ifEmpty { "jpg" }
            val file = File(folder, "${System.nanoTime()}.$extension")
            contentResolver.openInputStream(uri)?.use { input ->
                file.outputStream().use { output -> input.copyTo(output) }
            }
            if (file.length() in 1..MAX_BYTES) file.absolutePath else null
        }
    } catch (_: Exception) {
        // A picture this app may not read, or one that went away, is left
        // out; the rest of the share still arrives.
        null
    }

    private fun sizeOf(uri: Uri): Long =
        contentResolver.query(uri, arrayOf(OpenableColumns.SIZE), null, null, null)?.use {
            if (it.moveToFirst() && !it.isNull(0)) it.getLong(0) else 0L
        } ?: 0L

    private companion object {
        const val CHANNEL = "so.kyron.app/share"

        /** As many as a post or a message can carry. */
        const val MAX_FILES = 10

        /** The server's limit on one attachment. */
        const val MAX_BYTES = 25L * 1024 * 1024
    }
}
