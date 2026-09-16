import '../l10n/app_localizations.dart';

// lib/screens/ar_lens_screen.dart
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/face_anchor.dart';
import '../models/lens.dart';
import '../models/lens_effect.dart';
import '../models/post_media.dart';
import '../providers/composer_provider.dart';
import '../services/app_log.dart';
import '../services/attachment_images.dart';
import '../services/exposure_meter.dart';
import '../services/face_tracker.dart';
import '../services/lens_catalogue.dart';
import '../services/lens_renderer.dart';
import '../services/skin_sampler.dart';
import '../widgets/empty_state.dart';
import '../widgets/face_attachment_painter.dart';
import '../widgets/face_reticle.dart';
import '../widgets/lens_effect_layer.dart';
import '../services/platform_support.dart';
import '../widgets/kyron_app_bar.dart';

/// The camera, with a lens over it.
///
/// This replaces `ComingSoonScreen.arLens()`, which said lenses were not built
/// and kept the camera closed -- which was honest at the time.
///
/// A lens is any of three things: a colour transform over the whole frame,
/// pictures hung on a tracked face, and effects that change the face itself.
/// All three are applied to the live preview and baked into the saved file by
/// the same code, so the picture taken is the picture seen -- which is the one
/// thing this screen must never get wrong.
///
/// See docs/LENS_FORMAT.md for what a lens may contain, and docs/AR.md for
/// what the tracking does and does not do.
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

  @override
  ConsumerState<ArLensScreen> createState() => _ArLensScreenState();
}

class _ArLensScreenState extends ConsumerState<ArLensScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  int _cameraIndex = 0;

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

  /// The whole mesh behind [_face]. Attachments only need an anchor, but an
  /// effect is a region cut out of a face and a region needs the point cloud.
  List<FacePoint>? _landmarks;

  /// The skin colour read off this face, eased between frames. Null until a
  /// face has been seen, and a fill draws nothing without it.
  Color? _skin;

  /// The size of the frames the tracker is reading, which is what the
  /// landmarks are normalised against.
  Size _frame = Size.zero;

  /// Whether frames are being fed to the tracker. Only true while a lens
  /// actually needs a face: tracking a face for a colour filter is battery
  /// spent on nothing.
  bool _streaming = false;

  /// Built-ins until the catalogue answers, so the strip is never empty and
  /// never waits on a disk read.
  List<Lens> _lenses = Lens.builtIn;
  Lens _lens = Lens.builtIn.first;
  bool _opening = true;
  bool _capturing = false;
  String? _problem;

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
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _controller = null;
      controller.dispose();
      if (mounted) setState(() {});
    } else if (state == AppLifecycleState.resumed) {
      _open();
    }
  }

  Future<void> _open() async {
    // camera ships android, ios and web. Everywhere else there is nothing to
    // open, and the lens screen says so rather than failing as though a
    // camera were present and refusing.
    if (!PlatformSupport.current.camera) {
      setState(() {
        _opening = false;
        _problem =
            'The lens camera is not on '
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

      final controller = CameraController(
        found[_cameraIndex % found.length],
        ResolutionPreset.high,
        enableAudio: false,
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

      setState(() {
        _cameras = found;
        _controller = controller;
        _opening = false;
      });
    } on CameraException catch (error) {
      AppLog.instance.error('ar', 'Camera would not open: ${error.code}');
      if (!mounted) return;
      setState(() {
        _opening = false;
        // Named, because the two are fixed in different places: one in the
        // system settings and one not at all.
        _problem = error.code == 'CameraAccessDenied'
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

  /// Picks a lens, and starts or stops face tracking to match.
  ///
  /// Tracking runs only while something needs it. A colour filter does not,
  /// and inference on every frame for a lens that ignores the answer is
  /// somebody's battery spent on nothing.
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

  /// Opens the camera up until the face is exposed, frame by frame.
  ///
  /// [region] is where to look: the face when there is one, and the middle of
  /// the frame before there is. The reading is taken from the frame the
  /// tracker just saw rather than from a preview widget, so what is metered is
  /// exactly what the detector was given.
  void _meterOnTheFace(CameraImage frame, Rect region) {
    final controller = _controller;
    if (controller == null || _adjustingExposure) return;

    final (min, max) = _exposureRange;
    if (!(max > min)) return;

    final read = SkinSampler.forCameraImage(frame);
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
    controller
        .setExposureOffset(wanted)
        .catchError((Object error) {
          AppLog.instance.error('ar', 'Could not set the exposure: $error');
          return 0.0;
        })
        .whenComplete(() => _adjustingExposure = false);
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

  Future<void> _choose(Lens lens) async {
    setState(() => _lens = lens);

    if (!lens.needsFace) {
      await _stopTracking();
      return;
    }

    // Fetch first: a lens whose pictures have not arrived would otherwise
    // track a face and draw nothing on it.
    if (await _pictures.load(lens) && mounted) setState(() {});
    await _startTracking();
  }

  Future<void> _startTracking() async {
    if (_streaming) return;
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (!await _tracker.open()) {
      if (!mounted) return;
      // Said out loud rather than left as a lens that quietly does nothing.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).faceTrackingUnavailable),
        ),
      );
      return;
    }

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
    if (mounted) setState(() => _face = null);
  }

  /// One camera frame.
  ///
  /// Deliberately cheap: the tracker drops frames it is too busy for, and this
  /// only rebuilds when the answer actually changed from what is on screen.
  void _onFrame(CameraImage frame) {
    if (!_streaming || !mounted) return;

    final points = _tracker.track(
      frame,
      rotationDegrees: _controller?.description.sensorOrientation ?? 0,
    );
    final size = Size(frame.width.toDouble(), frame.height.toDouble());

    if (points == null) {
      // Metered on the middle of the frame *because* there is no face: an
      // underexposed one is the likeliest reason there is no face, and waiting
      // for a detection before fixing the exposure would wait forever.
      _meterOnTheFace(frame, ExposureMeter.regionForSelfie(size));
      if (_face != null) setState(_lost);
      return;
    }

    // Attachments hang off whatever the lens asked for. An effects-only lens
    // has nothing to ask, and the eyes are the right default: the gap between
    // the pupils is the unit every region and every blur is stated in.
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

    setState(() {
      _face = anchor;
      _landmarks = points;
      _frame = size;
      if (skin != null) _skin = _settle(_skin, skin);
    });
  }

  void _lost() {
    _face = null;
    _landmarks = null;
    // Dropped with the face rather than kept: the next face through the
    // viewfinder is somebody else, and easing their fill out of the last
    // person's skin tone would be visible.
    _skin = null;
  }

  /// The skin colour in this frame, or null when it cannot be read.
  Color? _readSkin(CameraImage frame, List<FacePoint> points, Size size) {
    final read = SkinSampler.forCameraImage(frame);
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
    if (_cameras.length < 2) return;
    final controller = _controller;
    _controller = null;
    setState(() => _opening = true);
    await controller?.dispose();
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    // The two cameras have their own exposure. Carrying the front camera's
    // compensation over to the back one exposes for a scene that is no longer
    // in front of the lens.
    _exposure.reset();
    await _open();
  }

  /// Takes the picture, bakes the lens into it, and hands it to the composer.
  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || _capturing) return;

    setState(() => _capturing = true);
    try {
      final shot = await controller.takePicture();
      final baked = await _bake(shot);

      ref.read(composerProvider.notifier).attachFile(baked, MediaKind.image);
      if (!mounted) return;
      Navigator.pop(context, baked);
    } catch (error) {
      AppLog.instance.error('ar', 'Could not take the picture: $error');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).couldNotTakePicture),
        ),
      );
    } finally {
      if (mounted) setState(() => _capturing = false);
    }
  }

  /// Writes the captured frame back out with the lens applied.
  ///
  /// The preview and the file go through the same [Lens.matrix]; without this
  /// the photograph would come back plain and the viewfinder would have been
  /// lying.
  Future<String> _bake(XFile shot) async {
    final attachments = _pictures.ready(_lens);
    final effects = _lens.effects;
    if (_lens.filter == null && attachments.isEmpty && effects.isEmpty) {
      return shot.path;
    }

    final bytes = await shot.readAsBytes();
    final decoded = await _decode(bytes);
    final filtered = await widget.renderer.apply(decoded, _lens);
    // Effects first, attachments over them -- the order the preview stacks
    // them in, because it is the same picture.
    final changed = effects.isEmpty
        ? filtered
        : await _drawEffects(filtered, effects);
    final drawn = attachments.isEmpty
        ? changed
        : await _drawAttachments(changed, attachments);
    final png = await widget.renderer.encode(drawn);

    final directory = await getTemporaryDirectory();
    final path = p.join(
      directory.path,
      'lens_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await File(path).writeAsBytes(png, flush: true);
    return path;
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

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawImage(photo, ui.Offset.zero, ui.Paint());
    const LensEffectBaker().paint(
      canvas,
      photo,
      effects,
      landmarks: points,
      face: face,
      frame: size,
      skin: skin,
    );

    final picture = recorder.endRecording();
    try {
      return await picture.toImage(photo.width, photo.height);
    } finally {
      picture.dispose();
    }
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

  /// The attachments, drawn onto the captured still.
  ///
  /// The same painter the preview uses, against a face found in the photograph
  /// itself rather than the last preview frame. That costs one more inference
  /// per shutter press and is worth it: the preview's last frame is from
  /// before the shutter, and a head that moved in between would leave the
  /// glasses somewhere the eyes are not.
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

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawImage(photo, ui.Offset.zero, ui.Paint());
    FaceAttachmentPainter(
      attachments: attachments,
      face: _scaled(face, scale),
    ).paint(canvas, size);

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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _streaming = false;
    _tracker.dispose();
    _pictures.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The whole screen under the dark theme, whatever the phone is set to.
    // A viewfinder is a black surface either way, and everything drawn over
    // it -- the bar, the strip, the shutter -- belongs to the camera rather
    // than to the app around it.
    return Theme(
      data: KyronTheme.darkTheme,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: KyronAppBar(
          backgroundColor: Colors.black,
          // Spelled out rather than left to `foregroundColor`, which does not
          // win: the design system's AppBarTheme sets titleTextStyle and
          // iconTheme, and a theme's own colours beat the widget's
          // foregroundColor. Under the light theme that put near-black text
          // and a near-black back arrow on this black bar, and the top of the
          // screen was simply blank.
          //
          // The theme's own style with the colour changed, not a fresh one:
          // a TextStyle written out here *replaces* the design system's
          // rather than merging with it, and takes the type family down with
          // it. That is how the sign-in screen's legal line ended up in
          // whatever font the platform happened to hand back.
          titleTextStyle: KyronTheme.darkTheme.appBarTheme.titleTextStyle
              ?.copyWith(color: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_copy),
            onPressed: () => Navigator.pop(context),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          ),
          title: Text(AppLocalizations.of(context).arLens),
          actions: [
            if (_cameras.length > 1)
              IconButton(
                icon: const Icon(Iconsax.refresh_copy),
                onPressed: _opening ? null : _flip,
                tooltip: AppLocalizations.of(context).literalswitchCamera,
              ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _viewfinder()),
              _LensStrip(
                lenses: _lenses,
                selected: _lens,
                onChanged: _choose,
                camera: _problem == null ? _controller : null,
                pictures: _pictures,
              ),
              _shutter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewfinder() {
    if (_problem != null) {
      return Center(
        child: EmptyState(
          art: EmptyArt.lens,
          title: AppLocalizations.of(context).literaltheCameraIsClosed,
          detail: _problem!,
          action: 'Try again',
          onAction: _open,
        ),
      );
    }

    final controller = _controller;
    if (_opening || controller == null || !controller.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    // The same filter the file gets. One definition, two places it is drawn.
    final preview = CameraPreview(controller);
    final filter = _lens.filter;
    final tinted = filter == null
        ? preview
        : ColorFiltered(colorFilter: filter, child: preview);

    final front =
        controller.description.lensDirection == CameraLensDirection.front;

    return Center(
      child: AspectRatio(
        aspectRatio: 1 / controller.value.aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            tinted,
            // Under the attachments on purpose: glasses go on a frosted
            // face, not behind the frost.
            if (_lens.effects.isNotEmpty) _effects(front),
            if (_lens.needsFace) _attachments(front),
            if (_lens.needsFace && _face == null) const FaceReticle(),
          ],
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
  /// against. Cheap enough to work out on demand -- it is a subtraction, an
  /// atan2 and a distance -- so it is not another field to keep in step.
  FaceAnchor? get _eyes {
    final points = _landmarks;
    if (points == null || _frame.isEmpty) return null;
    return FaceAnchor.resolve(FaceAnchorPoint.eyes, points, _frame);
  }

  /// The attachments, over the preview, at the size the preview is drawn.
  ///
  /// The landmarks are normalised to the camera frame, so they map onto
  /// whatever box the preview occupies -- which is why the anchor is resolved
  /// against [_frame] and then rescaled here rather than being computed in
  /// screen pixels somewhere further up.
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
    centre: Offset(face.centre.dx * scale.width, face.centre.dy * scale.height),
    // One number for a measurement that has two axes: a preview stretched
    // unevenly would make the choice matter, and the preview is drawn at
    // the camera's own aspect ratio precisely so it is not.
    interpupillary: face.interpupillary * scale.width,
    rollDegrees: face.rollDegrees,
  );

  Widget _shutter() {
    final ready = _controller != null && _problem == null && !_opening;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingTokens.space20),
      child: Semantics(
        button: true,
        label: AppLocalizations.of(context).literaltakeAPicture,
        child: GestureDetector(
          onTap: ready && !_capturing ? _capture : null,
          child: Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: ready ? 1 : 0.35),
              border: Border.all(color: Colors.white24, width: 4),
            ),
            child: _capturing
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.black54,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

/// The lenses, as a row of squircles you scroll.
///
/// Each tile shows the lens *doing its own job*, on what the camera is
/// pointing at right now: the colour matrix is applied to a live thumbnail of
/// the preview, a frost effect blurs and lifts that thumbnail the way it will
/// blur and lift a face, and a lens that hangs pictures on a face shows the
/// picture it hangs. The name of the chosen one sits above the row.
///
/// The row was a line of pills reading "None", "Mono", "Sunset". A name is
/// not a preview -- nobody knows what Sunset does to their face until they
/// tap it, and there is no reason to make them find out one at a time when
/// the camera is already running and every one of these is a filter over the
/// same frame.
class _LensStrip extends StatelessWidget {
  final List<Lens> lenses;
  final Lens selected;
  final ValueChanged<Lens> onChanged;

  /// The running camera. Null when it has not opened or cannot, in which case
  /// every tile falls back to a colour chart -- which still shows what a
  /// matrix does, and does not pretend to be a photograph of anything.
  final CameraController? camera;

  /// The decoded artwork, so a lens that hangs a picture on a face can show
  /// that picture rather than a word.
  final AttachmentImages pictures;

  const _LensStrip({
    required this.lenses,
    required this.selected,
    required this.onChanged,
    required this.camera,
    required this.pictures,
  });

  /// Big enough to read a face in, small enough that a dozen of them fit.
  static const double _tile = 58;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
          // Kept out of the accessibility tree on purpose: it repeats the
          // name of the tile that is already announcing itself as selected,
          // and read out it would say every lens's name twice as the row is
          // swiped.
          child: ExcludeSemantics(
            child: Text(
              selected.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: TypographyTokens.fontSize2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          height: _tile + SpacingTokens.space8,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingTokens.space16,
            ),
            itemCount: lenses.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: SpacingTokens.space8),
            itemBuilder: (context, index) {
              final lens = lenses[index];
              return Center(
                child: _LensTile(
                  lens: lens,
                  chosen: lens.id == selected.id,
                  size: _tile,
                  camera: camera,
                  pictures: pictures,
                  onTap: () => onChanged(lens),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// One lens, as a squircle showing what it does.
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
    // A squircle, not a rounded rectangle: ContinuousRectangleBorder carries
    // the corner's curvature into the straight edges instead of meeting them
    // at a tangent, which is the difference somebody means by the word.
    final shape = const ContinuousRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(RadiusTokens.radius20)),
    );

    return Semantics(
      button: true,
      selected: chosen,
      label: lens.needsFace ? '${lens.name}, face lens' : lens.name,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: size,
          height: size,
          decoration: ShapeDecoration(
            shape: shape.copyWith(
              side: BorderSide(
                color: chosen ? Colors.white : Colors.white24,
                width: chosen ? 2.5 : 1,
              ),
            ),
            color: Colors.black,
          ),
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: shape),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _preview(),
                // The one thing a picture cannot say about itself: this lens
                // needs a face, so pointed at a wall it will do nothing.
                if (lens.needsFace)
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(SpacingTokens.space2),
                      child: Icon(
                        Iconsax.scan_copy,
                        size: 11,
                        color: Colors.white70,
                        shadows: [Shadow(blurRadius: 3)],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// The lens, applied to whatever the tile has to apply it to.
  Widget _preview() {
    Widget base = _base();

    final filter = lens.filter;
    if (filter != null) {
      base = ColorFiltered(colorFilter: filter, child: base);
    }

    final frost = lens.effects.whereType<FrostEffect>().firstOrNull;
    if (frost != null) base = _frosted(frost, base);

    final artwork = pictures.ready(lens);
    if (artwork.isNotEmpty) {
      base = Stack(
        fit: StackFit.expand,
        children: [
          base,
          // The first attachment, at roughly the share of a face it will
          // cover: a width is in pupil-gaps, and a face fills about two
          // thirds of a frame this size.
          Center(
            child: FractionalTranslation(
              translation: const Offset(0, 0.1),
              child: SizedBox(
                width: (size * 0.22 * artwork.first.attachment.width).clamp(
                  size * 0.2,
                  size * 0.9,
                ),
                child: RawImage(
                  image: artwork.first.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (lens.attachments.isNotEmpty) {
      // Its pictures have not arrived. Say the lens is a sticker lens rather
      // than showing an unfiltered thumbnail that claims it does nothing.
      base = Stack(
        fit: StackFit.expand,
        children: [
          base,
          Center(
            child: Icon(Iconsax.gallery, size: 18, color: Colors.white70),
          ),
        ],
      );
    }

    if (lens.effects.any((effect) => effect is FillEffect)) {
      // A fill takes skin sampled from the face and paints a region of that
      // same face with it. There is no honest miniature of that without a
      // face in the tile, so this says what kind of lens it is and stops.
      base = Stack(
        fit: StackFit.expand,
        children: [
          base,
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(SpacingTokens.space2),
              child: Icon(
                Iconsax.brush_2,
                size: 11,
                color: Colors.white70,
                shadows: [Shadow(blurRadius: 3)],
              ),
            ),
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

    // The preview is drawn at the camera's own aspect ratio and cropped to
    // the square, the same way the viewfinder above draws it -- so the tile
    // is a thumbnail of the viewfinder and not a differently stretched one.
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
    // `blur` is in pupil-gaps, like everything else in the format. A face in
    // a tile this size has its pupils about a fifth of the tile apart.
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

/// What a tile shows when there is no camera to show.
///
/// A ramp through the colours a matrix is judged on -- a skin tone, a sky, a
/// leaf, a highlight and a shadow -- so a filter over it says truthfully what
/// that filter does. Deliberately a chart rather than a photograph: there is
/// no stand-in face in this app, and a stock one would be a picture of
/// somebody who is not holding the phone.
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
