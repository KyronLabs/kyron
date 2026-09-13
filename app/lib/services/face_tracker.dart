// lib/services/face_tracker.dart
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:mediapipe_face_mesh/mediapipe_face_mesh.dart';

import '../models/face_anchor.dart';
import 'app_log.dart';

/// Finds a face in camera frames.
///
/// A thin wrapper on purpose. Everything that decides where an attachment goes
/// is arithmetic in [FaceAnchor], which is tested against a real detection;
/// this is the part that cannot be tested without a camera, so it is kept as
/// small as it can be and does nothing but hand landmarks over.
class FaceTracker {
  FaceMeshProcessor? _processor;

  /// True while a frame is in the native graph.
  ///
  /// Inference is a synchronous FFI call and a camera delivers frames faster
  /// than it finishes. Without this the queue grows without bound and the
  /// overlay drifts further behind the preview with every frame -- which looks
  /// like bad tracking rather than a backlog. A dropped frame is invisible;
  /// a growing lag is not.
  bool _busy = false;

  bool get isReady => _processor != null;

  /// Starts the tracker. Answers false when it could not, which is not fatal:
  /// the camera still works and colour lenses still apply.
  Future<bool> open() async {
    if (_processor != null) return true;
    try {
      _processor = await FaceMeshProcessor.create(
        // The 478-point model. The extra ten are the irises, and the irises
        // are what everything is measured against -- see FaceAnchor.resolve.
        model: FaceMeshModel.v2,
        enableSmoothing: true,
        enableRoiTracking: true,
        delegate: FaceMeshDelegate.xnnpack,
        allowDelegateFallback: true,
        // All three of these default to 0.5, and this passed none of them.
        //
        // The detector scores how sure it is that a patch is a face, and that
        // score falls with contrast. A face that is underexposed -- which is
        // where a dark-skinned face lands when a phone meters for the whole
        // scene, see ExposureMeter -- scores in the thirties and forties on
        // frames where a well-lit one scores over 0.9. At 0.5 those frames are
        // thrown away, and it reads as the tracker not seeing somebody's face.
        //
        // What is bought by keeping 0.5 is fewer false positives, and here a
        // false positive means a pair of sunglasses briefly landing on a door
        // handle. That is worth far less than the frames it costs.
        minDetectionConfidence: 0.3,
        // Once a face is held, the bar to keep holding it is lower again:
        // losing a face that is still there makes the attachment blink, which
        // is worse to look at than a moment of slight drift.
        minTrackingConfidence: 0.25,
        minFacePresenceConfidence: 0.3,
      );
      return true;
    } catch (error) {
      AppLog.instance.error('ar', 'Face tracking would not start: $error');
      return false;
    }
  }

  /// The landmarks in one frame, or null when there is no face in it.
  ///
  /// Null is the ordinary case, not an error: somebody points the camera at a
  /// wall and there is nothing to put glasses on.
  List<FacePoint>? track(
    CameraImage frame, {
    int rotationDegrees = 0,
    bool mirrored = false,
  }) {
    final processor = _processor;
    if (processor == null || _busy) return null;

    _busy = true;
    try {
      final result = _process(processor, frame, rotationDegrees, mirrored);
      if (result == null ||
          result.landmarks.length < FaceAnchor.requiredLandmarks) {
        return null;
      }
      return [
        for (final point in result.landmarks) FacePoint(point.x, point.y),
      ];
    } catch (error) {
      AppLog.instance.error('ar', 'A frame could not be tracked: $error');
      return null;
    } finally {
      _busy = false;
    }
  }

  /// The one platform-shaped part: two operating systems hand over pixels in
  /// two different arrangements.
  FaceMeshResult? _process(
    FaceMeshProcessor processor,
    CameraImage frame,
    int rotationDegrees,
    bool mirrored,
  ) {
    if (Platform.isAndroid) {
      // Requested as NV21 when the controller is built, so this is the plane
      // layout the graph already wants and nothing has to be converted.
      final plane = frame.planes.first;
      final image = FaceMeshNv21Image.tryFromSinglePlane(
        bytes: plane.bytes,
        width: frame.width,
        height: frame.height,
        bytesPerRow: plane.bytesPerRow,
      );
      if (image == null) return null;
      return processor.processNv21(
        image,
        rotationDegrees: rotationDegrees,
        mirrorHorizontal: mirrored,
      );
    }

    // iOS delivers BGRA8888 in a single plane, which the graph takes directly.
    final plane = frame.planes.first;
    return processor.process(
      FaceMeshImage(
        pixels: plane.bytes,
        width: frame.width,
        height: frame.height,
        bytesPerRow: plane.bytesPerRow,
        pixelFormat: FaceMeshPixelFormat.bgra,
      ),
      rotationDegrees: rotationDegrees,
      mirrorHorizontal: mirrored,
    );
  }

  void dispose() {
    _processor?.close();
    _processor = null;
  }
}
