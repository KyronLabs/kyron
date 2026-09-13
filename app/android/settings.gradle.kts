pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
    // Reads app/google-services.json and generates the string resources the
    // Firebase SDK looks for at runtime. 4.4.4 is the version firebase_core
    // names in its own pubspec under `firebase:
    // google_services_gradle_plugin_version`, so the two cannot drift apart
    // silently.
    id("com.google.gms.google-services") version "4.4.4" apply false
}

include(":app")
