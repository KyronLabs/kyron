allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// One NDK for the app and every plugin: kyron.ndkVersion, in gradle.properties.
//
// A plugin that builds native code names its own NDK, and the Android Gradle
// Plugin installs whatever each module names. mediapipe_face_mesh 2.9.0 names
// 26.3.11579264 while the app builds with 28.2.13676358, so every Android
// build downloaded both, in the middle of the build -- and Release 19 failed
// twelve minutes in when the second download arrived corrupt ("Archive is
// not a ZIP archive"). Holding every plugin to the app's NDK leaves one to
// install, and scripts/install-ndk.sh installs it before Gradle starts.
//
// Set after each plugin has configured itself, so it wins over what the
// plugin wrote. Through Groovy's dynamic dispatch rather than the typed
// LibraryExtension: a plugin can bring its own copy of the Android Gradle
// Plugin on its own classpath (mediapipe_face_mesh does), and a type check
// against ours would quietly match nothing.
val kyronNdkVersion: String = providers.gradleProperty("kyron.ndkVersion").get()
subprojects {
    if (name != "app") {
        afterEvaluate {
            extensions.findByName("android")?.withGroovyBuilder {
                "setNdkVersion"(kyronNdkVersion)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
