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

// Every APK out of one build carries this, and Android will not install a
// package whose versionCode is lower than the one already on the phone.
//
// `--split-per-abi` makes Flutter's Gradle plugin rewrite each split to
// `abi * 1000 + build`, so build 78 shipped four files with four different
// numbers -- armeabi-v7a 1078, arm64-v8a 2078, x86_64 4078 -- while the
// universal APK kept the plain 78. Install the arm64 one and then try the
// universal one, which is exactly what somebody does when the first attempt
// fails, and the installer refuses it as a downgrade. The words it shows are
// "App not installed as package appears to be invalid".
//
// That scheme is for uploading several APKs to the Play Store, which this
// project does not do -- it ships an .aab there, and these APKs are
// sideloaded. So every APK in a build gets one number.
//
// The 100000 is not decoration. Going uniform without it would mean build 79
// carrying versionCode 79, which is *lower* than the 2078 already on anybody
// who installed build 78's arm64 APK -- one more refused install, caused by
// the fix. Every number from here is above every number already published.
//
// scripts/check-apks.sh fails the build if the APKs ever disagree again.
val kyronVersionCode = 100000 + flutter.versionCode

// Which architectures the APK carries.
//
// `--target-platform` restricts Flutter's own libraries -- libapp.so and
// libflutter.so -- and nothing else. With `--split-per-abi` gone, the Flutter
// Gradle Plugin fills the build type's abiFilters with all of arm, arm64 and
// x64 regardless of what was asked for, so an APK built `--target-platform
// android-arm64` came out carrying libtensorflowlite_c.so for x86_64 too:
// 6.6 MB of code that architecture will never run.
//
// Flutter passes the platforms through as a Gradle property, so they are read
// back here and applied in buildTypes below. With no --target-platform it
// passes all of them, which is what makes the universal APK universal.
val ABIS = mapOf(
    "android-arm" to "armeabi-v7a",
    "android-arm64" to "arm64-v8a",
    "android-x86" to "x86",
    "android-x64" to "x86_64",
)
val kyronAbis = (project.findProperty("target-platform") as String? ?: "")
    .split(",")
    .mapNotNull { ABIS[it.trim()] }

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
        versionCode = kyronVersionCode
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

            // On the build type, not defaultConfig, because that is where the
            // Flutter Gradle Plugin puts its own -- it clears
            // `buildType.ndk.abiFilters` and fills it with all of arm,
            // arm64 and x64 whenever `--split-per-abi` is off -- and a build
            // type's filters win over defaultConfig's. Setting this in
            // defaultConfig looked right, reported `[arm64-v8a]` at the end of
            // configuration, and changed nothing about the APK.
            //
            // This block runs after that one: the plugin configures during
            // apply(), at the top of this file, and this is further down.
            if (kyronAbis.isNotEmpty()) {
                ndk {
                    abiFilters.clear()
                    abiFilters.addAll(kyronAbis)
                }
            }
        }
    }
}

// `--split-per-abi` is the thing that breaks the rule above, and it cannot be
// undone after the fact: the Flutter Gradle Plugin rewrites each split's
// versionCode during configuration, and by the time anything here could set
// it back the Android Gradle Plugin has finalised the property --
// "The value for this property cannot be changed any further."
//
// So it is refused at the point where somebody would type it, rather than
// discovered four files later. Build one architecture at a time instead:
//
//   flutter build apk --release --target-platform android-arm64
//
// which produces the same APK, at the same size, carrying the versionCode
// this file asked for. Both workflows do exactly that.
if ((project.findProperty("split-per-abi") as String?)?.toBoolean() == true) {
    throw GradleException(
        "--split-per-abi gives each APK a different versionCode " +
            "(abi * 1000 + build) and leaves the universal APK on the lowest " +
            "of them, so the second file somebody tries is refused as a " +
            "downgrade -- in the words \"App not installed as package " +
            "appears to be invalid\". Build one architecture at a time: " +
            "flutter build apk --release --target-platform android-arm64"
    )
}

flutter {
    source = "../.."
}
