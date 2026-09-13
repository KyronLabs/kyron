import java.util.Properties

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Firebase, for push. The Google services plugin turns google-services.json
// into the string resources the SDK reads at startup, which is why
// Firebase.initializeApp() needs no options on Android.
//
// Applied only when the file is there, and the file is gitignored: it names
// the Firebase project, its sender id and its app ids, and this repository is
// public. Unconditional, this plugin fails the build outright, so every fresh
// clone -- and every CI job that does not write the file out of a secret --
// would stop here. Without it the app still builds and runs; it simply cannot
// register for push, and says so in its log rather than pretending.
//
// A release must not ship that quietly, so the release workflow checks the
// file was written before it builds. A contributor's checkout is where this
// leniency belongs; a published APK is not.
val googleServices = file("google-services.json")
if (googleServices.exists()) {
    apply(plugin = "com.google.gms.google-services")
} else {
    logger.lifecycle(
        "google-services.json is not in android/app, so this build will have " +
            "no push notifications. See docs/PUSH.md."
    )
}

android {
    namespace = "so.kyron.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Google Play rejects com.example.* outright, so the template default
        // this replaced could never have been published. Changing it renames
        // the package: an installed build will not update over one with the
        // old id, and has to be uninstalled first.
        applicationId = "so.kyron.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }
    buildTypes {
        release {
            // Local builds remain runnable without credentials; CI release builds require key.properties.
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}
