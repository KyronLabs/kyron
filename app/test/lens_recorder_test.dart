import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/lens_recorder.dart';

/// The native side, as calls it was sent, answering as LensRecorder.kt does.
class _Native {
  final calls = <MethodCall>[];

  /// When set, a frame is not answered until this completes: an encoder
  /// still busy with it.
  Completer<void>? hold;

  bool failStart = false;

  Future<Object?> handle(MethodCall call) async {
    calls.add(call);
    switch (call.method) {
      case 'start':
        if (failStart) throw PlatformException(code: 'start-failed');
        return null;
      case 'frame':
        await hold?.future;
        return true;
      case 'stop':
        return (calls.first.arguments as Map)['path'];
      default:
        return null;
    }
  }

  List<String> get methods => [for (final c in calls) c.method];
}

const _channel = MethodChannel('test/lens_recorder');

RecorderFrame _frame({int width = 640, int height = 480}) => RecorderFrame(
      bytes: Uint8List(width * height * 3 ~/ 2),
      width: width,
      height: height,
      stride: width,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _Native native;

  setUp(() {
    native = _Native();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, native.handle);
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('opens on the first frame, at its size, turned as the sensor is',
      () async {
    final recorder = LensFrameRecorder(channel: _channel)
      ..begin(path: '/tmp/a.mp4', rotationDegrees: 270);
    recorder.add(_frame(), const Duration(milliseconds: 5));
    await settle();
    await settle();

    expect(native.methods, ['start', 'frame']);
    expect(native.calls.first.arguments, {
      'path': '/tmp/a.mp4',
      'width': 640,
      'height': 480,
      'rotation': 270,
    });
    // Stamped with the recording's clock, the one the lens timeline uses.
    expect((native.calls[1].arguments as Map)['pts'], 5000);
  });

  test('asks for even sides, which a 4:2:0 encoder needs', () async {
    final recorder = LensFrameRecorder(channel: _channel)
      ..begin(path: '/tmp/a.mp4', rotationDegrees: 90);
    recorder.add(_frame(width: 641, height: 361), Duration.zero);
    await settle();
    final start = native.calls.first.arguments as Map;
    expect(start['width'], 640);
    expect(start['height'], 360);
  });

  test('drops a frame that arrives while the last is still encoding', () async {
    final recorder = LensFrameRecorder(channel: _channel)
      ..begin(path: '/tmp/a.mp4', rotationDegrees: 90);
    native.hold = Completer<void>();
    recorder.add(_frame(), const Duration(milliseconds: 1));
    await settle();
    recorder.add(_frame(), const Duration(milliseconds: 34));
    recorder.add(_frame(), const Duration(milliseconds: 67));
    expect(recorder.dropped, 2);

    native.hold!.complete();
    await settle();
    await settle();
    recorder.add(_frame(), const Duration(milliseconds: 100));
    await settle();
    expect(native.methods.where((m) => m == 'frame'), hasLength(2));
  });

  test('finishes with the file once the last frame is in', () async {
    final recorder = LensFrameRecorder(channel: _channel)
      ..begin(path: '/tmp/a.mp4', rotationDegrees: 90);
    recorder.add(_frame(), const Duration(milliseconds: 1));
    final path = await recorder.finish();
    expect(path, '/tmp/a.mp4');
    expect(native.methods.last, 'stop');
    expect(recorder.taken, 1);
  });

  test('answers nothing usable when the encoder would not open', () async {
    native.failStart = true;
    final recorder = LensFrameRecorder(channel: _channel)
      ..begin(path: '/tmp/a.mp4', rotationDegrees: 90);
    recorder.add(_frame(), Duration.zero);
    await settle();
    expect(recorder.recording, isFalse);
    expect(await recorder.finish(), isNull);
    expect(native.methods, isNot(contains('stop')));
  });

  test('a recording with no frames at all is nothing, not an empty file',
      () async {
    final recorder = LensFrameRecorder(channel: _channel)
      ..begin(path: '/tmp/a.mp4', rotationDegrees: 90);
    expect(await recorder.finish(), isNull);
    expect(native.methods, ['cancel']);
  });
}
