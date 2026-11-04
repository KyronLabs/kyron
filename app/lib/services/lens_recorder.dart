// lib/services/lens_recorder.dart
import 'dart:async';
import 'package:flutter/services.dart';

import 'app_log.dart';

/// One camera frame as the recorder needs it: NV21 bytes on a row stride.
class RecorderFrame {
  final Uint8List bytes;
  final int width;
  final int height;
  final int stride;

  const RecorderFrame({
    required this.bytes,
    required this.width,
    required this.height,
    required this.stride,
  });
}

/// Records a lens video from the frames the face is tracked in.
///
/// The camera's own recording cannot run beside those frames on many
/// phones: CameraX merges the preview and the video into one shared stream
/// that arrives already rotated, and the preview went on its side the moment
/// recording started. Preview plus frames -- what the screen runs before
/// recording -- works everywhere, so a lens recording keeps exactly that and
/// hands the frames to the phone's hardware encoder (LensRecorder.kt). The
/// sound is recorded alongside and laid in when the lens is.
///
/// One frame is in flight at a time. A frame that arrives while the last is
/// still being encoded is dropped, never queued: a queue on a slow phone
/// grows for the whole clip and the video ends long after the recording did.
class LensFrameRecorder {
  LensFrameRecorder({MethodChannel? channel})
      : _channel = channel ?? defaultChannel;

  static const defaultChannel = MethodChannel('so.kyron.app/lens_recorder');

  final MethodChannel _channel;

  String? _path;
  int _rotation = 0;
  bool _started = false;
  bool _failed = false;
  Future<void>? _inFlight;

  /// Frames the encoder took, and frames dropped because it was busy.
  int taken = 0;
  int dropped = 0;

  /// Where the video goes, and how the sensor is turned. Nothing is opened
  /// until the first frame says how big the frames are.
  void begin({required String path, required int rotationDegrees}) {
    _path = path;
    _rotation = rotationDegrees;
    _started = false;
    _failed = false;
    taken = 0;
    dropped = 0;
  }

  bool get recording => _path != null && !_failed;

  /// Offers one frame, stamped [at] from the start of the recording -- the
  /// clock the lens timeline is stamped with, so each lens picture lands on
  /// the frame it was tracked in.
  void add(RecorderFrame frame, Duration at) {
    final path = _path;
    if (path == null || _failed) return;
    if (_inFlight != null) {
      dropped++;
      return;
    }
    _inFlight = _send(path, frame, at).whenComplete(() => _inFlight = null);
  }

  Future<void> _send(String path, RecorderFrame frame, Duration at) async {
    try {
      if (!_started) {
        await _channel.invokeMethod<void>('start', {
          'path': path,
          // Even sides: a 4:2:0 encoder refuses odd ones.
          'width': frame.width & ~1,
          'height': frame.height & ~1,
          'rotation': _rotation,
        });
        _started = true;
      }
      final took = await _channel.invokeMethod<bool>('frame', {
        'bytes': frame.bytes,
        'stride': frame.stride,
        'pts': at.inMicroseconds,
      });
      if (took == true) {
        taken++;
      } else {
        dropped++;
      }
    } on PlatformException catch (error) {
      _failed = true;
      AppLog.instance
          .error('ar', 'Lens recorder: ${error.code} ${error.message}');
    } on MissingPluginException {
      _failed = true;
    }
  }

  /// Ends the file and answers its path, or null when nothing usable was
  /// recorded.
  Future<String?> finish() async {
    final path = _path;
    _path = null;
    await _inFlight;
    if (path == null || !_started || _failed) {
      await cancel();
      return null;
    }
    try {
      return await _channel.invokeMethod<String>('stop');
    } on PlatformException catch (error) {
      AppLog.instance.error('ar', 'Lens recorder stop: ${error.message}');
      return null;
    }
  }

  /// Drops whatever was being recorded.
  Future<void> cancel() async {
    _path = null;
    try {
      await _channel.invokeMethod<void>('cancel');
    } on PlatformException {
      // Nothing to cancel.
    } on MissingPluginException {
      // Not on this platform.
    }
  }
}
