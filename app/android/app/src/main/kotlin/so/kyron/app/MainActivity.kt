package so.kyron.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.OpenableColumns
import android.view.WindowManager
import androidx.activity.enableEdgeToEdge
import io.flutter.embedding.android.FlutterFragmentActivity
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
 *
 * A [FlutterFragmentActivity] rather than a FlutterActivity, for one thing:
 * [enableEdgeToEdge] belongs to androidx's ComponentActivity, which the plain
 * FlutterActivity is not. It is the same engine hosted in a fragment.
 */
class MainActivity : FlutterFragmentActivity() {
    private var channel: MethodChannel? = null

    /** A share that arrived before Flutter asked for it. Taken once. */
    private var waiting: Map<String, Any?>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        // Edge to edge on every Android version, not only from 15 on.
        //
        // Targeting SDK 35 or later, Android 15 draws every app edge to edge
        // whatever it asks for; before 15 an app only is if it says so. So
        // Kyron was edge to edge on new phones and not on older ones -- and
        // on older ones it became edge to edge halfway through a session,
        // the first time the media viewer closed and restored the system
        // bars. Play flags that as "edge-to-edge may not display for all
        // users". Asked for here, before the window is made, it is one
        // layout everywhere: the screens already keep clear of the bars
        // (SafeArea, the tab bar's own inset), because on Android 15 they
        // have had to.
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        createChannels()
        // Not on a re-creation: the intent is the one already handled, and
        // offering it again would open the share sheet a second time.
        if (savedInstanceState == null) waiting = read(intent)
    }

    /**
     * The two kinds of notification Kyron sends, as channels the phone's
     * settings list separately: Messages, which may pop up over whatever is
     * on screen, and Activity -- likes, replies, follows -- which may not.
     * A push naming a channel that does not exist lands in a catch-all one
     * called Miscellaneous, at whatever importance that has.
     *
     * Creating a channel that exists already changes nothing, so this runs on
     * every launch.
     */
    private fun createChannels() {
        if (Build.VERSION.SDK_INT < 26) return
        val manager = getSystemService(NotificationManager::class.java) ?: return
        manager.createNotificationChannels(
            listOf(
                NotificationChannel(
                    "messages",
                    "Messages",
                    NotificationManager.IMPORTANCE_HIGH,
                ).apply { description = "Direct messages sent to you" },
                NotificationChannel(
                    "activity",
                    "Activity",
                    NotificationManager.IMPORTANCE_DEFAULT,
                ).apply { description = "Likes, replies, mentions and new followers" },
            ),
        )
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
        // While a view-once photo, clip or voice note is open: no
        // screenshot, no screen recording, and a blank card in the recent
        // apps rather than the picture. A view that anybody could keep with
        // two buttons is not a view once. See docs/MESSAGING.md.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SECURE).setMethodCallHandler { call, result ->
            when (call.method) {
                "secure" -> {
                    if (call.arguments == true) {
                        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                    } else {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                    }
                    result.success(null)
                }
                else -> result.notImplemented()
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

        const val SECURE = "so.kyron.app/secure"

        /** As many as a post or a message can carry. */
        const val MAX_FILES = 10

        /** The server's limit on one attachment. */
        const val MAX_BYTES = 25L * 1024 * 1024
    }
}
