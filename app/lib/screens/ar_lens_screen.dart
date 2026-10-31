// lib/screens/ar_lens_screen.dart
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../l10n/app_localizations.dart';
import '../models/face_anchor.dart';
import '../models/glasses_model.dart';
import '../models/head_pose.dart';
import '../models/lens.dart';
import '../models/lens_effect.dart';
import '../models/post_media.dart';
import '../providers/composer_provider.dart';
import '../routes.dart';
import '../services/app_log.dart';
import '../services/attachment_images.dart';
import '../services/exposure_meter.dart';
import '../services/face_tracker.dart';
import '../services/lens_catalogue.dart';
import '../services/lens_renderer.dart';
import '../services/platform_support.dart';
import '../services/skin_sampler.dart';
import '../widgets/empty_state.dart';
import '../widgets/face_attachment_painter.dart';
import '../widgets/face_reticle.dart';
import '../widgets/glasses_painter.dart';
import '../widgets/lens_effect_layer.dart';

/// Photo or video. One shutter, two jobs.
enum CaptureMode { photo, video }

/// The camera, with a lens over it.
///
/// Laid out the way every camera people already use is laid out -- Snapchat,
/// TikTok, RedNote -- because that is a vocabulary somebody arrives knowing:
/// the picture is the whole screen, the controls float on it, and the lenses
/// run through the shutter. Swipe and the lens under the shutter is the lens
/// on your face; press it and that is the picture.
///
/// A lens is a colour transform over the whole frame, pictures hung on a
/// tracked face, effects that change the face itself, or glasses built in
/// three dimensions and turned with the head. All of them are applied to the
/// live preview and baked into the saved file by the same code, so the
/// picture taken is the picture seen -- which is the one thing this screen
/// must never get wrong. That includes the crop and the mirror: the saved
/// photograph is exactly the part of the frame that was on screen, the right
/// way round for the person who was looking at it.
///
/// Video records the camera as it is. Baking a lens into video needs an
/// encoder this app does not have yet, and a recording that came back
/// without the glasses somebody was wearing in the viewfinder would be the
/// screen lying. So video mode takes the lens off, and says so. See
/// docs/AR.md.
class ArLensScreen extends ConsumerStatefulWidget {
  const ArLensScreen({
    super.key,
    this.cameras,
    this.renderer = const LensRenderer(),
    this.catalogue,
    this.tracker,
    this.pictures,
  });

  /// Injected by tests. Null means ask the platform, which is what the app
  /// does; an empty list is a device with no camera, which is a state this
  /// screen has to render rather than crash on.
  final List<CameraDescription>? cameras;

  final LensRenderer renderer;

  /// Where the lens strip comes from. Injected by tests; the app makes one.
  final LensCatalogue? catalogue;

  /// Face tracking. Injected by tests, which have no camera to track in.
  final FaceTracker? tracker;

  /// The pictures a lens hangs on a face.
  final AttachmentImages? pictures;

  /// The longest recording, as on every short-video app.
  static const maxRecording = Duration(seconds: 60);

  /// Which camera to open first: the front one.
  ///
  /// A lens camera is a selfie camera. It used to open on whichever camera
  /// the platform listed first -- the back one, on every Android phone -- so
  /// the first thing anybody saw was their floor, and the first thing they
  /// did was hunt for the flip button.
  static int initialCamera(List<CameraDescription> cameras) {
    final front = cameras.indexWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    return front < 0 ? 0 : front;
  }

  /// The middle of [photo] with the same shape as [viewport] -- what a cover
  /// fit showed of it.
  static Rect visibleCrop(Size photo, Size viewport) {
    if (photo.isEmpty || viewport.isEmpty) return Offset.zero & photo;
    final want = viewport.width / viewport.height;
    final have = photo.width / photo.height;
    // Within a percent is the same shape; cropping a few pixels off is a
    // re-encode for nothing.
    if ((want - have).abs() / want < 0.01) return Offset.zero & photo;
    if (have > want) {
      final width = photo.height * want;
      return Rect.fromLTWH((photo.width - width) / 2, 0, width, photo.height);
    }
    final height = photo.width / want;
    return Rect.fromLTWH(0, (photo.height - height) / 2, photo.width, height);
  }

  @override
  ConsumerState<ArLensScreen> createState() => _ArLensScreenState();
}

class _ArLensScreenState extends ConsumerState<ArLensScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  int? _cameraIndex;

  late final LensCatalogue _catalogue = widget.catalogue ?? LensCatalogue();
  late final FaceTracker _tracker = widget.tracker ?? FaceTracker();
  late final AttachmentImages _pictures = widget.pictures ?? AttachmentImages();

  /// Keeps the face lit well enough to be found. See [ExposureMeter].
  final _exposure = ExposureMeter();

  /// What this camera says it will accept, in stops. Both zero means it takes
  /// no exposure compensation at all, and the meter stays out of the way.
  (double, double) _exposureRange = (0, 0);
  bool _adjustingExposure = false;

  /// Where the face is right now, or null when there is not one.
  FaceAnchor? _face;

  /// Which way the head is facing, for lenses built in three dimensions.
  HeadPose? _pose;

  /// The whole mesh behind [_face]. Attachments only need an anchor, but an
  /// effect is a region cut out of a face and a region needs the point cloud.
  List<FacePoint>? _landmarks;

  /// The skin colour read off this face, eased between frames. Null until a
  /// face has been seen, and a fill draws nothing without it.
  Color? _skin;

  /// The size of the frames the tracker is reading, *upright* -- which is
  /// what the landmarks are normalised against. See [SkinSampler.uprightSize].
  Size _frame = Size.zero;

  /// The shape of the screen the preview is drawn into, so the saved photo
  /// can be cropped to exactly what was visible.
  Size _viewport = Size.zero;

  /// Whether frames are being fed to the tracker. Only true while a lens
  /// actually needs a face: tracking a face for a colour filter is battery
  /// spent on nothing.
  bool _streaming = false;

  /// Built-ins until the catalogue answers, so the strip is never empty and
  /// never waits on a disk read.
  List<Lens> _lenses = Lens.builtIn;
  Lens _lens = Lens.builtIn.first;

  /// The lens chosen in photo mode, restored on the way back from video.
  Lens _photoLens = Lens.builtIn.first;

  /// The lens whose pictures are on their way, so the shutter can say so.
  String? _fetching;

  CaptureMode _mode = CaptureMode.photo;
  FlashMode _flash = FlashMode.off;

  bool _opening = true;
  bool _capturing = false;
  String? _problem;

  bool _recording = false;
  final _recorded = Stopwatch();
  Timer? _recordTicker;

  /// The white blink when a photo is taken.
  bool _blink = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _open();
    _loadLenses();
  }

  /// Draws the cached catalogue, then refreshes it in the background.
  ///
  /// Two steps rather than one so a lens published last week is on screen
  /// immediately and a lens published this morning arrives a moment later.
  /// Neither step can empty the strip: both merge onto the built-ins.
  Future<void> _loadLenses() async {
    final cached = await _catalogue.lenses();
    if (!mounted) return;
    setState(() => _lenses = cached);

    unawaited(_warmStrip());

    final refreshed = await _catalogue.refresh();
    if (!mounted || refreshed == null) return;
    setState(() {
      _lenses = refreshed;
      // A lens that vanished from the catalogue between launches would
      // otherwise stay selected while no tile is ringed.
      if (!refreshed.any((lens) => lens.id == _lens.id)) {
        _lens = refreshed.first;
      }
    });
    unawaited(_warmStrip());
  }

  /// Frees the camera when the app goes away, and takes it back on return.
  ///
  /// A camera held in the background is a camera another app cannot open, and
  /// on Android it is also a green dot on somebody's status bar for a screen
  /// they are not looking at.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Not while one is already opening: the permission prompt steps the app
    // back and forward again in the middle of the first open.
    if (state == AppLifecycleState.resumed) {
      if (_controller == null && !_opening && _problem == null) _open();
      return;
    }

    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _controller = null;
      // The frames stop with the controller, and so does a recording: there
      // is no picking one back up on a camera that was let go.
      _streaming = false;
      _endRecordingState();
      controller.dispose();
      if (mounted) setState(() {});
    }
  }

  Future<void> _open() async {
    // camera ships android, ios and web. Everywhere else there is nothing to
    // open, and the lens screen says so rather than failing as though a
    // camera were present and refusing.
    if (!PlatformSupport.current.camera) {
      setState(() {
        _opening = false;
        _problem = 'The lens camera is not on '
            '${PlatformSupport.current.name} yet.';
      });
      return;
    }

    setState(() {
      _opening = true;
      _problem = null;
    });

    try {
      final found = widget.cameras ?? await availableCameras();
      if (found.isEmpty) {
        if (!mounted) return;
        setState(() {
          _opening = false;
          _problem = 'This device has no camera.';
        });
        return;
      }

      final index = _cameraIndex ??= ArLensScreen.initialCamera(found);
      final controller = CameraController(
        found[index % found.length],
        ResolutionPreset.high,
        // Only when recording. Asking for the microphone to take a photo is
        // a permission prompt nobody has a reason to accept.
        enableAudio: _mode == CaptureMode.video,
        // What the face graph reads without a conversion pass. Asking the
        // camera for the right arrangement is free; converting every frame is
        // not.
        imageFormatGroup: Platform.isAndroid
            ? ImageFormatGroup.nv21
            : ImageFormatGroup.bgra8888,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }

      await _meterOnTheMiddle(controller);
      await _applyFlash(controller);

      setState(() {
        _cameras = found;
        _controller = controller;
        _opening = false;
      });
      // A face lens chosen before the camera was ready, or still chosen when
      // it comes back from the background or a flip, is tracked on this
      // controller.
      if (_lens.needsFace) await _startTracking();
    } on CameraException catch (error) {
      AppLog.instance.error('ar', 'Camera would not open: ${error.code}');
      if (!mounted) return;
      setState(() {
        _opening = false;
        // Named, because the two are fixed in different places: one in the
        // system settings and one not at all.
        _problem = error.code == 'CameraAccessDenied' ||
                error.code == 'AudioAccessDenied'
            ? 'Kyron does not have permission to use the camera. You can '
                'grant it in your device settings.'
            : 'The camera would not open.';
      });
    } catch (error) {
      AppLog.instance.error('ar', 'Camera would not open: $error');
      if (!mounted) return;
      setState(() {
        _opening = false;
        _problem = 'The camera would not open.';
      });
    }
  }

  /// Lets the camera go and opens it again: after a flip, or a change of mode
  /// that needs the microphone.
  Future<void> _reopen() async {
    final controller = _controller;
    _controller = null;
    // Its frames end with it; [_open] starts them again on the new camera.
    _streaming = false;
    setState(() {
      _opening = true;
      _face = null;
      _pose = null;
      _landmarks = null;
    });
    await controller?.dispose();
    await _open();
  }

  /// Points the camera's exposure and focus at the middle of the frame.
  ///
  /// Somebody holding a phone at arm's length has their head there, and left
  /// to itself the camera meters the whole scene -- so a bright window behind
  /// them takes the exposure down and their face with it. On light skin the
  /// face still lands mid-range; on dark skin it lands in the bottom stop,
  /// which is where both the picture and the face detector fall apart.
  ///
  /// Not every device takes either instruction. A device that does not says
  /// so, and there is nothing to do about it but carry on.
  Future<void> _meterOnTheMiddle(CameraController controller) async {
    const middle = Offset(0.5, 0.45);
    try {
      if (controller.value.exposurePointSupported) {
        await controller.setExposurePoint(middle);
      }
      if (controller.value.focusPointSupported) {
        await controller.setFocusPoint(middle);
      }
      _exposureRange = (
        await controller.getMinExposureOffset(),
        await controller.getMaxExposureOffset(),
      );
    } on CameraException catch (error) {
      AppLog.instance.error('ar', 'Could not meter the camera: ${error.code}');
      _exposureRange = (0, 0);
    }
  }

  bool get _front =>
      _controller?.description.lensDirection == CameraLensDirection.front;

  /// The flash, as chosen, on the camera that is open. A front camera has no
  /// flash to fire, so it is always off there.
  Future<void> _applyFlash(CameraController controller) async {
    final front =
        controller.description.lensDirection == CameraLensDirection.front;
    try {
      await controller.setFlashMode(front ? FlashMode.off : _flash);
    } on CameraException catch (error) {
      AppLog.instance.error('ar', 'Could not set the flash: ${error.code}');
    }
  }

  Future<void> _toggleFlash() async {
    final controller = _controller;
    if (controller == null) return;
    HapticFeedback.selectionClick();
    setState(() {
      _flash = switch (_flash) {
        FlashMode.off =>
          _mode == CaptureMode.video ? FlashMode.torch : FlashMode.always,
        _ => FlashMode.off,
      };
    });
    await _applyFlash(controller);
  }

  /// Opens the camera up until the face is exposed, frame by frame.
  ///
  /// [region] is where to look, in the upright picture: the face when there
  /// is one, and the middle of the frame before there is. The reading is
  /// taken from the frame the tracker just saw rather than from a preview
  /// widget, so what is metered is exactly what the detector was given.
  void _meterOnTheFace(CameraImage frame, Rect region) {
    final controller = _controller;
    if (controller == null || _adjustingExposure) return;

    final (min, max) = _exposureRange;
    if (!(max > min)) return;

    final read = _reader(frame);
    if (read == null) return;
    final luma = ExposureMeter.luma(read: read, region: region);
    if (luma == null) return;

    final wanted = _exposure.offsetFor(
      luma: luma,
      min: min,
      max: max,
      now: DateTime.now(),
    );
    if (wanted == null) return;

    _adjustingExposure = true;
    // Not awaited in a frame callback: the camera is on the platform thread
    // and the next frame is already on its way.
    controller.setExposureOffset(wanted).catchError((Object error) {
      AppLog.instance.error('ar', 'Could not set the exposure: $error');
      return 0.0;
    }).whenComplete(() => _adjustingExposure = false);
  }

  int get _rotation => _controller?.description.sensorOrientation ?? 0;

  /// The frame's pixels, addressed the way the landmarks are: upright.
  ReadPixel? _reader(CameraImage frame) {
    final raw = SkinSampler.forCameraImage(frame);
    if (raw == null) return null;
    return SkinSampler.upright(
      raw,
      width: frame.width,
      height: frame.height,
      rotationDegrees: _rotation,
    );
  }

  /// Fetches the artwork for the lenses in the strip, so each tile can show
  /// the picture it hangs rather than a placeholder.
  ///
  /// Stops well short of the cache's ceiling. Eviction is oldest-first, so a
  /// strip that warmed past it would quietly take away whatever the
  /// viewfinder is drawing right now.
  Future<void> _warmStrip() async {
    for (final lens in _lenses) {
      if (lens.attachments.isEmpty) continue;
      if (_pictures.cached + lens.attachments.length >
          AttachmentImages.maxCached - 4) {
        return;
      }
      final arrived = await _pictures.load(lens);
      if (!mounted) return;
      if (arrived) setState(() {});
    }
  }

  /// Picks a lens, and starts or stops face tracking to match.
  ///
  /// Tracking runs only while something needs it. A colour filter does not,
  /// and inference on every frame for a lens that ignores the answer is
  /// somebody's battery spent on nothing.
  Future<void> _choose(Lens lens) async {
    if (lens.id == _lens.id) return;
    setState(() {
      _lens = lens;
      _photoLens = lens;
    });

    if (!lens.needsFace) {
      await _stopTracking();
      return;
    }

    if (lens.attachments.isNotEmpty) {
      // Fetch first: a lens whose pictures have not arrived would otherwise
      // track a face and draw nothing on it. The shutter spins meanwhile,
      // rather than the lens looking as though it did nothing.
      setState(() => _fetching = lens.id);
      final arrived = await _pictures.load(lens);
      if (!mounted) return;
      setState(() {
        if (_fetching == lens.id) _fetching = null;
      });
      if (!arrived && _pictures.ready(lens).isEmpty) {
        // ignore: use_build_context_synchronously
        _say(AppLocalizations.of(context)
            .ui('ar_lens_not_loaded', 'That lens could not be loaded.'));
      }
    }
    // Something else was picked while the pictures were arriving.
    if (!mounted || _lens.id != lens.id) return;
    await _startTracking();
  }

  Future<void> _startTracking() async {
    if (_streaming || _startingTracking) return;
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    _startingTracking = true;
    try {
      await _streamFrom(controller);
    } finally {
      _startingTracking = false;
    }
  }

  /// True while [_startTracking] is opening the tracker or the stream, so a
  /// lens picked and the camera opening at the same moment start it once.
  bool _startingTracking = false;

  Future<void> _streamFrom(CameraController controller) async {
    if (!await _tracker.open()) {
      if (!mounted) return;
      // Said out loud rather than left as a lens that quietly does nothing.
      _say(AppLocalizations.of(context).faceTrackingUnavailable);
      return;
    }

    // The camera went away, or a colour lens was picked, while the tracker
    // was starting.
    if (!mounted || _controller != controller || !_lens.needsFace) return;

    try {
      await controller.startImageStream(_onFrame);
      _streaming = true;
    } catch (error) {
      AppLog.instance.error('ar', 'Could not read camera frames: $error');
    }
  }

  Future<void> _stopTracking() async {
    if (!_streaming) return;
    _streaming = false;
    try {
      await _controller?.stopImageStream();
    } catch (_) {
      // Already stopped, or the camera went away underneath. Either way there
      // is nothing left to stop.
    }
    if (mounted) setState(_lost);
  }

  /// One camera frame.
  ///
  /// Deliberately cheap: the tracker drops frames it is too busy for, and this
  /// only rebuilds when the answer actually changed from what is on screen.
  void _onFrame(CameraImage frame) {
    if (!_streaming || !mounted) return;

    final rotation = _rotation;
    final points = _tracker.track(frame, rotationDegrees: rotation);
    // Upright: the tracker turned the frame before it looked, and its
    // landmarks are normalised to the turned picture. See
    // SkinSampler.uprightSize for what using the raw size did.
    final size = SkinSampler.uprightSize(
      Size(frame.width.toDouble(), frame.height.toDouble()),
      rotation,
    );

    if (points == null) {
      // Metered on the middle of the frame *because* there is no face: an
      // underexposed one is the likeliest reason there is no face, and waiting
      // for a detection before fixing the exposure would wait forever.
      _meterOnTheFace(frame, ExposureMeter.regionForSelfie(size));
      if (_face != null) setState(_lost);
      return;
    }

    // Attachments hang off whatever the lens asked for. Anything else is
    // measured from the eyes: the gap between the pupils is the unit every
    // region, every blur and every pair of glasses is stated in.
    final anchor = FaceAnchor.resolve(
      _lens.attachments.isEmpty
          ? FaceAnchorPoint.eyes
          : _lens.attachments.first.anchor,
      points,
      size,
    );
    if (anchor == null) {
      if (_face != null) setState(_lost);
      return;
    }

    _meterOnTheFace(
      frame,
      ExposureMeter.regionAround(anchor.centre, anchor.interpupillary),
    );

    final skin = _lens.effects.any((effect) => effect is FillEffect)
        ? _readSkin(frame, points, size)
        : null;
    final pose = _lens.glasses == null ? null : HeadPose.resolve(points, size);

    setState(() {
      _face = anchor;
      _pose = pose;
      _landmarks = points;
      _frame = size;
      if (skin != null) _skin = _settle(_skin, skin);
    });
  }

  void _lost() {
    _face = null;
    _pose = null;
    _landmarks = null;
    // Dropped with the face rather than kept: the next face through the
    // viewfinder is somebody else, and easing their fill out of the last
    // person's skin tone would be visible.
    _skin = null;
  }

  /// The skin colour in this frame, or null when it cannot be read.
  Color? _readSkin(CameraImage frame, List<FacePoint> points, Size size) {
    final read = _reader(frame);
    if (read == null) return null;
    final eyes = FaceAnchor.resolve(FaceAnchorPoint.eyes, points, size);
    if (eyes == null) return null;
    return SkinSampler.sample(read: read, face: eyes);
  }

  /// Eased towards the new reading rather than snapped to it.
  ///
  /// Auto-exposure moves between frames and the sampled colour moves with it.
  /// Snapping makes the fill flicker; a quarter of the way per frame settles
  /// within a few frames and still follows somebody walking into shade.
  static Color _settle(Color? from, Color to) =>
      from == null ? to : Color.lerp(from, to, 0.25)!;

  Future<void> _flip() async {
    if (_cameras.length < 2 || _opening || _recording) return;
    HapticFeedback.selectionClick();
    _cameraIndex = ((_cameraIndex ?? 0) + 1) % _cameras.length;
    // The two cameras have their own exposure. Carrying the front camera's
    // compensation over to the back one exposes for a scene that is no longer
    // in front of the lens.
    _exposure.reset();
    await _reopen();
  }

  /// Photo or video.
  ///
  /// Video takes the lens off -- see the class comment -- and opens the
  /// camera again with the microphone, which a photo never asks for. Coming
  /// back puts the lens back.
  Future<void> _setMode(CaptureMode mode) async {
    if (mode == _mode || _recording || _capturing) return;
    HapticFeedback.selectionClick();
    final restore = _photoLens;
    setState(() {
      _mode = mode;
      if (_flash != FlashMode.off) _flash = FlashMode.off;
    });
    if (mode == CaptureMode.video) {
      await _stopTracking();
      setState(() => _lens = Lens.builtIn.first);
    } else {
      setState(() => _lens = restore);
    }
    if (_controller != null || _opening) await _reopen();
  }

  // -------------------------------------------------------------------------
  // Capture
  // -------------------------------------------------------------------------

  bool get _ready =>
      _controller != null && _problem == null && !_opening && !_capturing;

  void _onShutterTap() {
    if (!_ready) return;
    if (_mode == CaptureMode.photo) {
      _capture();
    } else if (_recording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _onShutterHold() {
    if (!_ready || _mode != CaptureMode.video || _recording) return;
    _heldToRecord = true;
    _startRecording();
  }

  void _onShutterRelease() {
    if (!_heldToRecord) return;
    _heldToRecord = false;
    if (_recording) _stopRecording();
  }

  /// Whether the recording running was started by holding the shutter, in
  /// which case letting go ends it.
  bool _heldToRecord = false;

  /// Takes the picture, bakes the lens into it, and hands it to the composer.
  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || _capturing) return;

    HapticFeedback.mediumImpact();
    setState(() {
      _capturing = true;
      _blink = true;
    });
    Timer(const Duration(milliseconds: 90), () {
      if (mounted) setState(() => _blink = false);
    });

    try {
      final shot = await controller.takePicture();
      final baked = await _bake(shot);
      if (!mounted) return;
      _toComposer(baked, MediaKind.image);
    } catch (error) {
      AppLog.instance.error('ar', 'Could not take the picture: $error');
      if (!mounted) return;
      _say(AppLocalizations.of(context).couldNotTakePicture);
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  Future<void> _startRecording() async {
    final controller = _controller;
    if (controller == null || _recording) return;
    HapticFeedback.mediumImpact();
    try {
      await controller.startVideoRecording();
      if (!mounted) return;
      setState(() => _recording = true);
      _recorded
        ..reset()
        ..start();
      _recordTicker = Timer.periodic(const Duration(milliseconds: 100), (_) {
        if (!mounted) return;
        if (_recorded.elapsed >= ArLensScreen.maxRecording) {
          _stopRecording();
        } else {
          setState(() {});
        }
      });
    } catch (error) {
      AppLog.instance.error('ar', 'Could not start recording: $error');
      _heldToRecord = false;
      if (!mounted) return;
      _say(AppLocalizations.of(context)
          .ui('ar_could_not_record', 'The video could not be recorded.'));
    }
  }

  Future<void> _stopRecording() async {
    final controller = _controller;
    if (controller == null || !_recording) return;
    _endRecordingState();
    setState(() => _capturing = true);
    try {
      final file = await controller.stopVideoRecording();
      if (!mounted) return;
      _toComposer(file.path, MediaKind.video);
    } catch (error) {
      AppLog.instance.error('ar', 'Could not finish recording: $error');
      if (!mounted) return;
      _say(AppLocalizations.of(context)
          .ui('ar_could_not_record', 'The video could not be recorded.'));
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  void _endRecordingState() {
    _recordTicker?.cancel();
    _recordTicker = null;
    _recorded.stop();
    _recording = false;
  }

  /// Attaches what was captured and opens the composer on it.
  ///
  /// This used to attach the file and pop -- back to wherever the camera was
  /// opened from, which is the home feed. The picture was in the composer's
  /// state, invisibly, until somebody happened to open it. A camera opened
  /// from "create" ends in the thing being created.
  void _toComposer(String path, MediaKind kind) {
    final composer = ref.read(composerProvider);
    if (!composer.canAddMedia) {
      _say(AppLocalizations.of(context).ui(
        'ar_composer_full',
        'Your post already has as many attachments as it can take.',
      ));
    } else {
      // Not awaited: it uploads in the background and the composer shows its
      // progress, which is the composer's job and not this screen's.
      unawaited(ref.read(composerProvider.notifier).attachFile(path, kind));
    }
    Navigator.of(context).pushReplacementNamed(Routes.composer);
  }

  void _say(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// Writes the captured frame back out with the lens applied, cropped and
  /// turned the way the viewfinder showed it.
  ///
  /// The preview and the file go through the same [Lens.matrix], the same
  /// painters and the same pose; without this the photograph would come back
  /// plain and the viewfinder would have been lying.
  Future<String> _bake(XFile shot) async {
    final attachments = _pictures.ready(_lens);
    final effects = _lens.effects;
    final glasses = _lens.glasses;

    final bytes = await shot.readAsBytes();
    final decoded = await _decode(bytes);
    final photoSize = Size(
      decoded.width.toDouble(),
      decoded.height.toDouble(),
    );
    final crop = ArLensScreen.visibleCrop(photoSize, _viewport);
    // Android hands back the front camera's photo the way the sensor saw it
    // -- the other way round from the mirror somebody was looking at. Turned
    // back here so the saved picture is the one on screen.
    final mirror = _front && Platform.isAndroid;

    final unchanged =
        !_lens.changesPicture && !mirror && crop == Offset.zero & photoSize;
    if (unchanged) return shot.path;

    final filtered = await widget.renderer.apply(decoded, _lens);
    // Effects first, then glasses and attachments over them -- the order the
    // preview stacks them in, because it is the same picture.
    final changed =
        effects.isEmpty ? filtered : await _drawEffects(filtered, effects);
    final worn = glasses == null ? changed : await _drawGlasses(changed);
    final drawn =
        attachments.isEmpty ? worn : await _drawAttachments(worn, attachments);
    final framed = await _frameAs(drawn, crop: crop, mirror: mirror);
    final png = await widget.renderer.encode(framed);

    final directory = await getTemporaryDirectory();
    final path = p.join(
      directory.path,
      'lens_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await File(path).writeAsBytes(png, flush: true);
    return path;
  }

  /// [photo] cut down to [crop] and flipped when [mirror] is set.
  Future<ui.Image> _frameAs(
    ui.Image photo, {
    required Rect crop,
    required bool mirror,
  }) async {
    final whole = Rect.fromLTWH(
      0,
      0,
      photo.width.toDouble(),
      photo.height.toDouble(),
    );
    if (crop == whole && !mirror) return photo;

    final width = crop.width.round();
    final height = crop.height.round();
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    if (mirror) {
      canvas.translate(width.toDouble(), 0);
      canvas.scale(-1, 1);
    }
    canvas.drawImageRect(
      photo,
      crop,
      Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      ui.Paint()..filterQuality = ui.FilterQuality.high,
    );
    final picture = recorder.endRecording();
    try {
      return await picture.toImage(width, height);
    } finally {
      picture.dispose();
    }
  }

  /// The effects, drawn into the captured still.
  ///
  /// No rescaling, unlike [_drawAttachments]: the landmarks are normalised,
  /// so resolving them against the photograph's own size puts every region
  /// straight into its coordinates. The still is several times the preview
  /// stream and a region is the shape of a jaw -- a scale factor slightly
  /// off would show as a seam along it.
  Future<ui.Image> _drawEffects(
    ui.Image photo,
    List<LensEffect> effects,
  ) async {
    final points = _landmarks;
    if (points == null) return photo;

    final size = Size(photo.width.toDouble(), photo.height.toDouble());
    final face = FaceAnchor.resolve(FaceAnchorPoint.eyes, points, size);
    if (face == null) return photo;

    // Read off the photograph rather than reused from the preview: this is
    // the picture being kept, at its own exposure and with the lens's colour
    // filter already in it, so a fill sampled anywhere else would be a patch
    // of a slightly different photograph. Falls back to the preview's
    // reading when the pixels cannot be had.
    final skin = await _skinIn(photo, points, size) ?? _skin;

    return _paintOver(photo, (canvas) {
      const LensEffectBaker().paint(
        canvas,
        photo,
        effects,
        landmarks: points,
        face: face,
        frame: size,
        skin: skin,
      );
    });
  }

  /// The glasses, drawn into the captured still from the same landmarks the
  /// preview drew them from, resolved at the photograph's own size.
  Future<ui.Image> _drawGlasses(ui.Image photo) async {
    final points = _landmarks;
    final model = _lens.glasses;
    if (points == null || model == null) return photo;

    final size = Size(photo.width.toDouble(), photo.height.toDouble());
    final pose = HeadPose.resolve(points, size);
    if (pose == null) return photo;

    return _paintOver(photo, (canvas) {
      GlassesPainter.paintGlasses(
        canvas,
        model,
        pose,
        face: _outline(points, size),
      );
    });
  }

  /// The skin colour in the photograph itself.
  Future<Color?> _skinIn(
    ui.Image photo,
    List<FacePoint> points,
    Size size,
  ) async {
    final face = FaceAnchor.resolve(FaceAnchorPoint.eyes, points, size);
    if (face == null) return null;
    final rgba = await photo.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (rgba == null) return null;
    return SkinSampler.sample(
      read: SkinSampler.forRgba(rgba, photo.width, photo.height),
      face: face,
    );
  }

  /// The attachments, drawn onto the captured still, with the same painter
  /// the preview uses and the last face the preview saw, rescaled to the
  /// photograph.
  Future<ui.Image> _drawAttachments(
    ui.Image photo,
    List<ResolvedAttachment> attachments,
  ) async {
    final face = _face;
    if (face == null) return photo;

    final size = Size(photo.width.toDouble(), photo.height.toDouble());
    final scale = Size(
      _frame.width <= 0 ? 1 : size.width / _frame.width,
      _frame.height <= 0 ? 1 : size.height / _frame.height,
    );

    return _paintOver(photo, (canvas) {
      FaceAttachmentPainter(
        attachments: attachments,
        face: _scaled(face, scale),
      ).paint(canvas, size);
    });
  }

  /// [photo], with [draw] painted over it, as a new image the same size.
  Future<ui.Image> _paintOver(
    ui.Image photo,
    void Function(ui.Canvas canvas) draw,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawImage(photo, ui.Offset.zero, ui.Paint());
    draw(canvas);
    final picture = recorder.endRecording();
    try {
      return await picture.toImage(photo.width, photo.height);
    } finally {
      picture.dispose();
    }
  }

  Future<ui.Image> _decode(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  /// Every landmark at [size], with depth: the surface the arms of a pair
  /// of glasses are hidden behind. Depth is normalised to the width.
  static List<Vec3> _outline(List<FacePoint> points, Size size) => [
        for (final point in points)
          Vec3(
            point.x * size.width,
            point.y * size.height,
            point.z * size.width,
          ),
      ];

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _streaming = false;
    _endRecordingState();
    _tracker.dispose();
    _pictures.dispose();
    _controller?.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Layout
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canFlip = _cameras.length > 1;
    final hasFlash = _controller != null && !_front && _problem == null;

    // The whole screen under the dark theme, whatever the phone is set to.
    // A viewfinder is a black surface either way, and everything drawn over
    // it belongs to the camera rather than to the app around it.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
      child: Theme(
        data: KyronTheme.darkTheme,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Double-tap anywhere on the picture flips the camera, as it
              // does in every camera app with a selfie side.
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: canFlip ? _flip : null,
                child: _viewfinder(),
              ),
              // Shades top and bottom, so white controls read over a white
              // ceiling or a white pillow.
              const _Scrim(top: true),
              const _Scrim(top: false),
              IgnorePointer(
                child: AnimatedOpacity(
                  opacity: _blink ? 0.85 : 0,
                  duration: Duration(milliseconds: _blink ? 30 : 220),
                  child: const ColoredBox(color: Colors.white),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space12,
                    vertical: SpacingTokens.space8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _GlassButton(
                        icon: Iconsax.close_circle_copy,
                        tooltip: MaterialLocalizations.of(context)
                            .closeButtonTooltip,
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      const Spacer(),
                      if (_recording) _RecordingTime(_recorded.elapsed),
                      const Spacer(),
                      Column(
                        children: [
                          if (canFlip)
                            _GlassButton(
                              icon: Iconsax.refresh_copy,
                              tooltip: l10n.literalswitchCamera,
                              onPressed: _opening || _recording ? null : _flip,
                            ),
                          if (hasFlash) ...[
                            const SizedBox(height: SpacingTokens.space12),
                            _GlassButton(
                              icon: _flash == FlashMode.off
                                  ? Iconsax.flash_slash_copy
                                  : Iconsax.flash_1,
                              tooltip: l10n.ui('ar_flash', 'Flash'),
                              onPressed: _toggleFlash,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(top: false, child: _controls()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _controls() {
    final l10n = AppLocalizations.of(context);
    final photo = _mode == CaptureMode.photo;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The chosen lens's name, which changes as the strip is swiped. Out
        // of the accessibility tree: the tile already announces itself as
        // selected, and read out this would say every name twice.
        ExcludeSemantics(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: Text(
              photo
                  ? _lens.name
                  : l10n.ui(
                      'ar_video_plain',
                      'Lenses are for photos, for now',
                    ),
              key: ValueKey(photo ? _lens.id : 'video'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: TypographyTokens.fontSize2,
                fontWeight: FontWeight.w600,
                shadows: [Shadow(blurRadius: 6, color: Colors.black54)],
              ),
            ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        SizedBox(
          height: _Shutter.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Hidden rather than removed in video mode, so swiping back to
              // photo finds the strip where it was left.
              AnimatedOpacity(
                opacity: photo ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: IgnorePointer(
                  ignoring: !photo,
                  child: _LensCarousel(
                    lenses: _lenses,
                    selected: _lens,
                    onChanged: _choose,
                    camera: _problem == null ? _controller : null,
                    pictures: _pictures,
                  ),
                ),
              ),
              _Shutter(
                mode: _mode,
                enabled: _ready || _recording,
                busy: _capturing || _fetching == _lens.id,
                recording: _recording,
                progress: _recording
                    ? _recorded.elapsed.inMilliseconds /
                        ArLensScreen.maxRecording.inMilliseconds
                    : 0,
                label: photo
                    ? l10n.literaltakeAPicture
                    : l10n.ui('ar_record_video', 'Record a video'),
                onTap: _onShutterTap,
                onHold: _onShutterHold,
                onRelease: _onShutterRelease,
              ),
            ],
          ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        _ModeSwitch(
          mode: _mode,
          enabled: !_recording && !_capturing,
          onChanged: _setMode,
        ),
        const SizedBox(height: SpacingTokens.space8),
      ],
    );
  }

  Widget _viewfinder() {
    if (_problem != null) {
      return SafeArea(
        child: Center(
          child: EmptyState(
            art: EmptyArt.lens,
            title: AppLocalizations.of(context).literaltheCameraIsClosed,
            detail: _problem!,
            action: 'Try again',
            onAction: _open,
          ),
        ),
      );
    }

    final controller = _controller;
    final live =
        !_opening && controller != null && controller.value.isInitialized;

    return LayoutBuilder(
      builder: (context, box) {
        _viewport = box.biggest;
        // Cross-faded rather than swapped: a camera that opens with a hard
        // cut from black, or from a spinner, is the "ugly" in how it loads.
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeOut,
          child: live
              ? KeyedSubtree(
                  key: ValueKey(controller),
                  child: _preview(controller),
                )
              : const _Warming(),
        );
      },
    );
  }

  /// The preview and everything drawn on it, filling the screen.
  ///
  /// Everything is laid out in one box the shape of the camera's frame and
  /// then scaled to cover the screen as a unit. The lens layers therefore sit
  /// in the same coordinates as the picture under them whatever the screen's
  /// shape -- which is what lets the preview fill a tall phone edge to edge
  /// instead of sitting letterboxed in the middle of it.
  Widget _preview(CameraController controller) {
    final preview = CameraPreview(controller);
    final filter = _lens.filter;
    final tinted = filter == null
        ? preview
        : ColorFiltered(colorFilter: filter, child: preview);

    final front =
        controller.description.lensDirection == CameraLensDirection.front;
    // The camera's aspect ratio is landscape; the phone is held upright.
    final ratio = controller.value.aspectRatio;
    const width = 1000.0;

    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: width,
          height: width * ratio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              tinted,
              // Under the glasses and attachments on purpose: glasses go on
              // a frosted face, not behind the frost.
              if (_lens.effects.isNotEmpty) _effects(front),
              if (_lens.glasses != null) _glasses(front),
              if (_lens.attachments.isNotEmpty) _attachments(front),
              if (_lens.needsFace && _face == null) const FaceReticle(),
            ],
          ),
        ),
      ),
    );
  }

  /// The effects, over the preview.
  Widget _effects(bool mirrored) {
    final face = _eyes;
    final points = _landmarks;
    if (face == null || points == null) return const SizedBox.shrink();

    return LensEffectOverlay(
      effects: _lens.effects,
      landmarks: points,
      face: face,
      frame: _frame,
      skin: _skin,
      mirrored: mirrored,
    );
  }

  /// The face measured from the eyes, which is what every effect is scaled
  /// against.
  FaceAnchor? get _eyes {
    final points = _landmarks;
    if (points == null || _frame.isEmpty) return null;
    return FaceAnchor.resolve(FaceAnchorPoint.eyes, points, _frame);
  }

  Widget _glasses(bool mirrored) {
    final pose = _pose;
    final points = _landmarks;
    final model = _lens.glasses;
    if (pose == null || points == null || model == null || _frame.isEmpty) {
      return const SizedBox.shrink();
    }
    return CustomPaint(
      painter: GlassesPainter(
        model: model,
        pose: pose,
        face: _outline(points, _frame),
        mirrored: mirrored,
        frame: _frame,
      ),
    );
  }

  /// The attachments, over the preview, at the size the preview is drawn.
  Widget _attachments(bool mirrored) {
    final face = _face;
    if (face == null || _frame.isEmpty) return const SizedBox.shrink();

    final ready = _pictures.ready(_lens);
    if (ready.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, box) {
        final scale = Size(
          box.maxWidth / _frame.width,
          box.maxHeight / _frame.height,
        );
        return CustomPaint(
          painter: FaceAttachmentPainter(
            attachments: ready,
            face: _scaled(face, scale),
            mirrored: mirrored,
          ),
        );
      },
    );
  }

  /// The same face, in the coordinates of a box of a different size.
  static FaceAnchor _scaled(FaceAnchor face, Size scale) => FaceAnchor(
        centre:
            Offset(face.centre.dx * scale.width, face.centre.dy * scale.height),
        // One number for a measurement that has two axes. With the frame
        // upright the two factors agree; they did not when it was not.
        interpupillary: face.interpupillary * scale.width,
        rollDegrees: face.rollDegrees,
      );
}

// ---------------------------------------------------------------------------
// Chrome
// ---------------------------------------------------------------------------

/// A soft shade over one edge of the picture.
class _Scrim extends StatelessWidget {
  final bool top;

  const _Scrim({required this.top});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: top ? Alignment.topCenter : Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: top ? 0.18 : 0.32,
          widthFactor: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: top ? Alignment.topCenter : Alignment.bottomCenter,
                end: top ? Alignment.bottomCenter : Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: top ? 0.45 : 0.55),
                  Colors.black.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// What is on screen while the camera opens: a dark field breathing gently,
/// rather than a spinner in the middle of a black page.
class _Warming extends StatefulWidget {
  const _Warming();

  @override
  State<_Warming> createState() => _WarmingState();
}

class _WarmingState extends State<_Warming>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_pulse.value);
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0, -0.2),
              radius: 0.9 + 0.1 * t,
              colors: [
                Color.lerp(
                  const Color(0xFF1C1C22),
                  const Color(0xFF26262E),
                  t,
                )!,
                Colors.black,
              ],
            ),
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

/// A round, translucent control floating on the picture.
class _GlassButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  const _GlassButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: onPressed,
          child: ClipOval(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                width: 42,
                height: 42,
                color: Colors.black.withValues(alpha: 0.28),
                child: Icon(
                  icon,
                  size: 22,
                  color: Colors.white.withValues(
                    alpha: onPressed == null ? 0.4 : 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// How long the recording has run, in a red pill at the top.
class _RecordingTime extends StatelessWidget {
  final Duration elapsed;

  const _RecordingTime(this.elapsed);

  @override
  Widget build(BuildContext context) {
    final seconds = elapsed.inSeconds;
    final text =
        '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
    return Container(
      margin: const EdgeInsets.only(top: SpacingTokens.space8),
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space12,
        vertical: SpacingTokens.space4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE5253A),
        borderRadius: BorderRadius.circular(RadiusTokens.radius20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontFeatures: [ui.FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

/// Photo or video, as two words under the shutter.
class _ModeSwitch extends StatelessWidget {
  final CaptureMode mode;
  final bool enabled;
  final ValueChanged<CaptureMode> onChanged;

  const _ModeSwitch({
    required this.mode,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget option(CaptureMode value, String label) {
      final chosen = value == mode;
      return Semantics(
        button: true,
        selected: chosen,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: enabled ? () => onChanged(value) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space12,
              vertical: SpacingTokens.space4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 160),
                  style: TextStyle(
                    color: chosen ? Colors.white : Colors.white60,
                    fontSize: TypographyTokens.fontSize2,
                    fontWeight: chosen ? FontWeight.w700 : FontWeight.w500,
                    shadows: const [
                      Shadow(blurRadius: 6, color: Colors.black54),
                    ],
                  ),
                  child: Text(label),
                ),
                const SizedBox(height: SpacingTokens.space4),
                AnimatedOpacity(
                  opacity: chosen ? 1 : 0,
                  duration: const Duration(milliseconds: 160),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        option(CaptureMode.photo, l10n.ui('ar_mode_photo', 'Photo')),
        option(CaptureMode.video, l10n.ui('ar_mode_video', 'Video')),
      ],
    );
  }
}

/// The shutter: a ring the lens strip runs through.
///
/// In photo mode the middle is open, so the lens tile under it shows through
/// -- the ring is around the lens that will be in the picture. In video mode
/// it is a red button; while recording it fills red around the edge as the
/// clock runs down.
class _Shutter extends StatefulWidget {
  final CaptureMode mode;
  final bool enabled;
  final bool busy;
  final bool recording;
  final double progress;
  final String label;
  final VoidCallback onTap;
  final VoidCallback onHold;
  final VoidCallback onRelease;

  const _Shutter({
    required this.mode,
    required this.enabled,
    required this.busy,
    required this.recording,
    required this.progress,
    required this.label,
    required this.onTap,
    required this.onHold,
    required this.onRelease,
  });

  static const double size = 86;

  @override
  State<_Shutter> createState() => _ShutterState();
}

class _ShutterState extends State<_Shutter> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final video = widget.mode == CaptureMode.video;
    final recording = widget.recording;

    return Semantics(
      button: true,
      label: widget.label,
      enabled: widget.enabled,
      excludeSemantics: true,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _down = true),
        onTapCancel: () => setState(() => _down = false),
        onTapUp: (_) => setState(() => _down = false),
        onTap: widget.enabled ? widget.onTap : null,
        onLongPressStart: (_) => widget.onHold(),
        onLongPressEnd: (_) {
          setState(() => _down = false);
          widget.onRelease();
        },
        child: AnimatedScale(
          scale: recording ? 1.18 : (_down ? 0.92 : 1),
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: SizedBox.square(
            dimension: _Shutter.size,
            child: CustomPaint(
              painter: _ShutterPainter(
                video: video,
                recording: recording,
                progress: widget.progress,
                enabled: widget.enabled,
              ),
              child: Center(
                child: widget.busy
                    ? const SizedBox.square(
                        dimension: _Shutter.size - 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: video ? (recording ? 28 : 62) : 0,
                        height: video ? (recording ? 28 : 62) : 0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5253A),
                          borderRadius: BorderRadius.circular(
                            recording ? 7 : 31,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShutterPainter extends CustomPainter {
  final bool video;
  final bool recording;
  final double progress;
  final bool enabled;

  const _ShutterPainter({
    required this.video,
    required this.recording,
    required this.progress,
    required this.enabled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 5.0;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    canvas.drawOval(
      rect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = Colors.white.withValues(alpha: enabled ? 1 : 0.4),
    );
    if (recording && progress > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress.clamp(0.0, 1.0),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..strokeCap = StrokeCap.round
          ..color = const Color(0xFFE5253A),
      );
    }
  }

  @override
  bool shouldRepaint(_ShutterPainter old) =>
      old.video != video ||
      old.recording != recording ||
      old.progress != progress ||
      old.enabled != enabled;
}

// ---------------------------------------------------------------------------
// The lens strip
// ---------------------------------------------------------------------------

/// The lenses, as a row of circles that scrolls through the shutter.
///
/// The one under the shutter is the one on your face: swiping changes lens
/// as it goes, every tile snaps to the middle, and tapping a tile brings it
/// there. Lenses sit on both sides of the shutter rather than in a shelf
/// above it, which is how every camera people already use does it, and
/// which puts the lens and the button that takes the picture under one
/// thumb.
class _LensCarousel extends StatefulWidget {
  final List<Lens> lenses;
  final Lens selected;
  final ValueChanged<Lens> onChanged;

  /// The running camera. Null when it has not opened or cannot, in which case
  /// colour tiles fall back to a colour chart -- which still shows what a
  /// matrix does, and does not pretend to be a photograph of anything.
  final CameraController? camera;

  /// The decoded artwork, so a lens that hangs a picture on a face can show
  /// that picture.
  final AttachmentImages pictures;

  const _LensCarousel({
    required this.lenses,
    required this.selected,
    required this.onChanged,
    required this.camera,
    required this.pictures,
  });

  /// A tile, and the room either side of it.
  static const double tile = 58;
  static const double pitch = 72;

  @override
  State<_LensCarousel> createState() => _LensCarouselState();
}

class _LensCarouselState extends State<_LensCarousel> {
  PageController? _pages;
  double _width = 0;

  int get _index {
    final i = widget.lenses.indexWhere((l) => l.id == widget.selected.id);
    return i < 0 ? 0 : i;
  }

  PageController _controllerFor(double width) {
    if (_pages == null || width != _width) {
      final page = _pages?.hasClients == true
          ? (_pages!.page ?? _index.toDouble()).round()
          : _index;
      _pages?.dispose();
      _width = width;
      _pages = PageController(
        initialPage: page,
        viewportFraction: (_LensCarousel.pitch / width).clamp(0.05, 1.0),
      );
    }
    return _pages!;
  }

  @override
  void didUpdateWidget(_LensCarousel old) {
    super.didUpdateWidget(old);
    // Chosen from outside -- the catalogue dropped the lens that was on, or
    // video mode took it off -- so the strip follows.
    final pages = _pages;
    if (pages != null &&
        pages.hasClients &&
        old.selected.id != widget.selected.id &&
        (pages.page ?? 0).round() != _index) {
      pages.jumpToPage(_index);
    }
  }

  @override
  void dispose() {
    _pages?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final pages = _controllerFor(box.maxWidth);
        return PageView.builder(
          controller: pages,
          itemCount: widget.lenses.length,
          onPageChanged: (index) {
            HapticFeedback.selectionClick();
            widget.onChanged(widget.lenses[index]);
          },
          itemBuilder: (context, index) {
            final lens = widget.lenses[index];
            return Center(
              child: AnimatedBuilder(
                animation: pages,
                builder: (context, child) {
                  // Tiles shrink and dim as they move away from the shutter,
                  // so the one in the middle reads as the one that is on.
                  final page = pages.hasClients && pages.position.haveDimensions
                      ? pages.page ?? _index.toDouble()
                      : _index.toDouble();
                  final distance = (page - index).abs().clamp(0.0, 3.0);
                  final scale = 1 - 0.12 * math.min(1.0, distance);
                  return Opacity(
                    opacity: 1 - 0.12 * math.min(2.0, distance),
                    child: Transform.scale(scale: scale, child: child),
                  );
                },
                child: _LensTile(
                  lens: lens,
                  chosen: lens.id == widget.selected.id,
                  size: _LensCarousel.tile,
                  camera: widget.camera,
                  pictures: widget.pictures,
                  onTap: () => pages.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOutCubic,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// One lens, as a circle showing what it does.
class _LensTile extends StatelessWidget {
  final Lens lens;
  final bool chosen;
  final double size;
  final CameraController? camera;
  final AttachmentImages pictures;
  final VoidCallback onTap;

  const _LensTile({
    required this.lens,
    required this.chosen,
    required this.size,
    required this.camera,
    required this.pictures,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: chosen,
      label: lens.needsFace ? '${lens.name}, face lens' : lens.name,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            border: Border.all(
              color: chosen ? Colors.white : Colors.white24,
              width: chosen ? 2 : 1,
            ),
            boxShadow: const [
              BoxShadow(blurRadius: 8, color: Colors.black38),
            ],
          ),
          child: ClipOval(child: _preview()),
        ),
      ),
    );
  }

  Widget _preview() {
    if (lens.id == Lens.builtIn.first.id) return const _NoneGlyph();

    final glasses = lens.glasses;
    if (glasses != null) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.3, -0.4),
            colors: [Color(0xFF3A3F4B), Color(0xFF15171C)],
          ),
        ),
        child: CustomPaint(
          painter: _GlassesThumbnail(glasses),
          child: const SizedBox.expand(),
        ),
      );
    }

    if (lens.attachments.isNotEmpty) {
      final artwork = pictures.ready(lens);
      if (artwork.isEmpty) return const _Shimmer();
      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF3A3F4B), Color(0xFF15171C)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(size * 0.12),
          child: RawImage(image: artwork.first.image, fit: BoxFit.contain),
        ),
      );
    }

    Widget base = _base();
    final filter = lens.filter;
    if (filter != null) {
      base = ColorFiltered(colorFilter: filter, child: base);
    }

    final frost = lens.effects.whereType<FrostEffect>().firstOrNull;
    if (frost != null) base = _frosted(frost, base);

    if (lens.effects.any((effect) => effect is FillEffect)) {
      // A fill takes skin sampled from the face and paints a region of that
      // same face with it. There is no honest miniature of that without a
      // face in the tile, so this says what kind of lens it is and stops.
      base = Stack(
        fit: StackFit.expand,
        children: [
          base,
          const ColoredBox(color: Color(0x55000000)),
          const Center(
            child: Icon(Iconsax.magicpen, size: 20, color: Colors.white),
          ),
        ],
      );
    }
    return base;
  }

  /// The live preview, square, or a colour chart when there is no camera.
  Widget _base() {
    final controller = camera;
    if (controller == null || !controller.value.isInitialized) {
      return const _ColourChart();
    }
    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size,
        height: size * controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
    );
  }

  /// Frost, in miniature: the same blur, desaturation and lift it will put on
  /// a face, applied to the whole tile instead of to a tracked region.
  Widget _frosted(FrostEffect frost, Widget child) {
    final sigma = (frost.blur * size * 0.2).clamp(0.5, 12.0);
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: ColorFiltered(
            colorFilter: ColorFilter.matrix(_saturation(1 - frost.desaturate)),
            child: child,
          ),
        ),
        if (frost.lift > 0)
          ColoredBox(
            color: Colors.white.withValues(alpha: frost.lift.clamp(0.0, 0.6)),
          ),
      ],
    );
  }

  /// The standard luminance-weighted saturation matrix.
  static List<double> _saturation(double amount) {
    const lr = 0.2126, lg = 0.7152, lb = 0.0722;
    final s = amount.clamp(0.0, 1.0);
    final ir = (1 - s) * lr, ig = (1 - s) * lg, ib = (1 - s) * lb;
    return <double>[
      ir + s, ig, ib, 0, 0, //
      ir, ig + s, ib, 0, 0, //
      ir, ig, ib + s, 0, 0, //
      0, 0, 0, 1, 0, //
    ];
  }
}

/// A pair of glasses in a tile, a little turned so it reads as solid.
class _GlassesThumbnail extends CustomPainter {
  final GlassesModel model;

  const _GlassesThumbnail(this.model);

  @override
  void paint(Canvas canvas, Size size) {
    final pose = HeadPose.facing(
      Offset(size.width / 2, size.height * 0.52),
      size.width * 0.3,
      yaw: 16,
    );
    GlassesPainter.paintGlasses(canvas, model, pose);
  }

  @override
  bool shouldRepaint(_GlassesThumbnail old) => old.model != model;
}

/// "No lens": an empty circle with a stroke through it.
class _NoneGlyph extends StatelessWidget {
  const _NoneGlyph();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NonePainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _NonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF1E2026),
    );
    final r = size.shortestSide * 0.22;
    final c = size.center(Offset.zero);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white70;
    canvas.drawCircle(c, r, paint);
    canvas.drawLine(
      c + Offset(-r * 0.7, r * 0.7),
      c + Offset(r * 0.7, -r * 0.7),
      paint,
    );
  }

  @override
  bool shouldRepaint(_NonePainter old) => false;
}

/// A tile whose picture has not arrived: a light sweeping across it, rather
/// than a placeholder icon that looks like the lens itself.
class _Shimmer extends StatefulWidget {
  const _Shimmer();

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sweep,
      builder: (context, _) {
        final x = -1.5 + 3 * _sweep.value;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(x - 0.6, -0.3),
              end: Alignment(x + 0.6, 0.3),
              colors: const [
                Color(0xFF22242B),
                Color(0xFF3A3D47),
                Color(0xFF22242B),
              ],
            ),
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

/// What a colour tile shows when there is no camera to show.
///
/// A ramp through the colours a matrix is judged on -- a skin tone, a sky, a
/// leaf, a highlight and a shadow -- so a filter over it says truthfully what
/// that filter does.
class _ColourChart extends StatelessWidget {
  const _ColourChart();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF2D3B8), // light skin
            Color(0xFF8D5524), // deep skin
            Color(0xFF4C8FFF), // sky
            Color(0xFF17D1B0), // leaf
            Color(0xFF1A1A1D), // shadow
          ],
          stops: [0.0, 0.3, 0.55, 0.78, 1.0],
        ),
      ),
    );
  }
}
