// lib/services/lens_camera.dart
import 'dart:io';

import 'package:camera_android_camerax/camera_android_camerax.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/foundation.dart';

import 'app_log.dart';

/// The Android camera plugin, with one stream fewer while a lens records.
///
/// Why: a lens recording needs the camera's frames while it records -- they
/// are what the face is tracked in, live and for baking the lens into the
/// clip. The plugin binds three CameraX streams when the camera opens
/// (preview, still photo, and the frames) and adds a fourth, video, when
/// recording starts. No phone runs four camera streams at once, so CameraX
/// quietly merges the preview and the video into one shared stream -- which
/// arrives already rotated. The plugin turns the preview to upright on the
/// assumption that it never is, so the moment recording started the picture
/// went on its side while the lens drawn over it stayed level.
///
/// A plain recording never showed this: without frames the plugin drops that
/// stream itself and stays at three. So this drops the one a recording does
/// not use, the still photo, and the recording runs on three. The plugin
/// binds it again by itself the next time a photo is taken.
///
/// The fix belongs in the plugin, which should read CameraX's transformation
/// info rather than assume it; this is the narrowest change that does not
/// mean carrying a copy of it.
class LensCameraX extends AndroidCameraCameraX {
  /// Makes this the camera implementation, on Android, once.
  static void install() {
    if (!Platform.isAndroid) return;
    if (CameraPlatform.instance is LensCameraX) return;
    CameraPlatform.instance = LensCameraX();
  }

  @override
  Future<void> startVideoCapturing(VideoCaptureOptions options) async {
    if (options.streamCallback != null) await releaseStillCapture();
    return super.startVideoCapturing(options);
  }

  /// Unbinds the still-photo stream, if it is bound.
  ///
  /// Not fatal when it fails: the recording still works, with the preview
  /// on its side on the phones that merge streams.
  @visibleForTesting
  Future<void> releaseStillCapture() async {
    // The plugin's own fields, marked for its tests; there is no other way
    // to reach the use case it bound.
    // ignore: invalid_use_of_visible_for_testing_member
    final provider = processCameraProvider;
    // ignore: invalid_use_of_visible_for_testing_member
    final still = imageCapture;
    if (provider == null || still == null) return;
    try {
      if (await provider.isBound(still)) await provider.unbind([still]);
    } catch (error) {
      AppLog.instance.error('ar', 'Could not release still capture: $error');
    }
  }
}
