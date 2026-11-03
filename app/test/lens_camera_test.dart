import 'package:camera_android_camerax/src/camerax_library.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/lens_camera.dart';

/// A camera provider that remembers what was unbound.
class _Provider extends ProcessCameraProvider {
  _Provider({required this.bound}) : super.pigeon_detached();

  bool bound;
  final unbound = <UseCase>[];

  @override
  Future<bool> isBound(UseCase useCase) async => bound;

  @override
  Future<void> unbind(List<UseCase> useCases) async {
    unbound.addAll(useCases);
    bound = false;
  }
}

/// The real thing up to the point it would reach the platform: whether the
/// still stream was released, and what super would have been asked.
class _Probe extends LensCameraX {
  final calls = <String>[];

  @override
  Future<void> releaseStillCapture() async {
    calls.add('release');
    await super.releaseStillCapture();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('releases the still stream before a recording that streams frames',
      () async {
    final camera = LensCameraX();
    final provider = _Provider(bound: true);
    final still = ImageCapture.pigeon_detached();
    // ignore: invalid_use_of_visible_for_testing_member
    camera.processCameraProvider = provider;
    // ignore: invalid_use_of_visible_for_testing_member
    camera.imageCapture = still;

    await camera.releaseStillCapture();

    expect(provider.unbound, [still]);
  });

  test('leaves it alone when it is not bound', () async {
    final camera = LensCameraX();
    final provider = _Provider(bound: false);
    // ignore: invalid_use_of_visible_for_testing_member
    camera.processCameraProvider = provider;
    // ignore: invalid_use_of_visible_for_testing_member
    camera.imageCapture = ImageCapture.pigeon_detached();

    await camera.releaseStillCapture();

    expect(provider.unbound, isEmpty);
  });

  test('only for recordings that stream frames', () async {
    // A plain recording already runs on three streams: the plugin drops the
    // frames itself. Releasing the still stream there would be for nothing.
    final probe = _Probe();
    await expectLater(
      probe.startVideoCapturing(const VideoCaptureOptions(1)),
      throwsA(anything), // super reaches for a camera there is not.
    );
    expect(probe.calls, isEmpty);

    await expectLater(
      probe.startVideoCapturing(VideoCaptureOptions(1, streamCallback: (_) {})),
      throwsA(anything),
    );
    expect(probe.calls, ['release']);
  });
}
