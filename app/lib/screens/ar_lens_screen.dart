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
import '../services/face_tracker.dart';
import '../services/lens_catalogue.dart';
import '../services/lens_renderer.dart';
import '../services/skin_sampler.dart';
import '../widgets/empty_state.dart';
import '../widgets/face_attachment_painter.dart';
import '../widgets/face_reticle.dart';
import '../widgets/lens_effect_layer.dart';

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

    final refreshed = await _catalogue.refresh();
    if (!mounted || refreshed == null) return;
    setState(() {
      _lenses = refreshed;
      // A lens that vanished from the catalogue between launches would
      // otherwise stay selected while no chip is filled.
      if (!refreshed.any((lens) => lens.id == _lens.id)) {
        _lens = refreshed.first;
      }
    });
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
        const SnackBar(
          content: Text('Face tracking is not available on this device.'),
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
        const SnackBar(content: Text('Could not take that picture.')),
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
    final changed =
        effects.isEmpty ? filtered : await _drawEffects(filtered, effects);
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('AR Lens'),
        actions: [
          if (_cameras.length > 1)
            IconButton(
              icon: const Icon(Iconsax.refresh_copy),
              onPressed: _opening ? null : _flip,
              tooltip: 'Switch camera',
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
            ),
            _shutter(),
          ],
        ),
      ),
    );
  }

  Widget _viewfinder() {
    if (_problem != null) {
      // Under the dark theme explicitly. A viewfinder is a black surface
      // whichever theme the phone is in, and the empty state takes its
      // colours from the theme -- so on a light-themed device this drew dark
      // grey text on black and the message could not be read at all.
      return Theme(
        data: KyronTheme.darkTheme,
        child: Center(
          child: EmptyState(
            art: EmptyArt.lens,
            title: 'The camera is closed',
            detail: _problem!,
            action: 'Try again',
            onAction: _open,
          ),
        ),
      );
    }

    final controller = _controller;
    if (_opening || controller == null || !controller.value.isInitialized) {
      return const Center(
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

  /// The effects, over the preview, in the camera frame's own coordinates.
  ///
  /// [FaceRegion] works in frame pixels because that is what the landmarks
  /// are normalised against, so rather than rescale every path this maps the
  /// whole layer once. The same transform carries the front camera's mirror:
  /// [CameraPreview] flips the front preview, and an effect built from raw
  /// landmarks would otherwise sit on the wrong side of a face.
  ///
  /// A uniform-enough scale matters here in a way it does not for a sticker:
  /// the blur is specified in frame pixels and the transform scales it, so an
  /// uneven scale would smear it into an ellipse. The preview is drawn at the
  /// camera's own aspect ratio precisely so the two factors agree.
  Widget _effects(bool mirrored) {
    final face = _eyes;
    final points = _landmarks;
    if (face == null || points == null || _frame.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, box) {
        final scale = box.maxWidth / _frame.width;
        final transform = Matrix4.identity()
          ..translateByDouble(mirrored ? box.maxWidth : 0, 0, 0, 1)
          ..scaleByDouble(
            mirrored ? -scale : scale,
            box.maxHeight / _frame.height,
            1,
            1,
          );

        return Transform(
          transform: transform,
          child: Stack(
            fit: StackFit.expand,
            children: [
              for (final effect in _lens.effects)
                LensEffectLayer(
                  effect: effect,
                  landmarks: points,
                  face: face,
                  frame: _frame,
                  skin: _skin,
                ),
            ],
          ),
        );
      },
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
        centre: Offset(
          face.centre.dx * scale.width,
          face.centre.dy * scale.height,
        ),
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
        label: 'Take a picture',
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

/// The lenses, as a row you scroll.
class _LensStrip extends StatelessWidget {
  final List<Lens> lenses;
  final Lens selected;
  final ValueChanged<Lens> onChanged;

  const _LensStrip({
    required this.lenses,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        itemCount: lenses.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: SpacingTokens.space8),
        itemBuilder: (context, index) {
          final lens = lenses[index];
          final chosen = lens.id == selected.id;

          return Center(
            child: Semantics(
              button: true,
              selected: chosen,
              label: lens.needsFace ? '${lens.name}, face lens' : lens.name,
              child: GestureDetector(
                onTap: () => onChanged(lens),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space16,
                    vertical: SpacingTokens.space8,
                  ),
                  decoration: BoxDecoration(
                    color: chosen ? Colors.white : Colors.white12,
                    borderRadius:
                        BorderRadius.circular(RadiusTokens.radiusFull),
                    // A lens that tracks a face behaves differently from one
                    // that tints the picture -- it can be pointed at a wall
                    // and do nothing. Worth being able to tell apart before
                    // tapping it rather than after.
                    border: lens.needsFace && !chosen
                        ? Border.all(color: Colors.white38, width: 1)
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (lens.needsFace) ...[
                        Icon(
                          Iconsax.scan_copy,
                          size: 14,
                          color: chosen ? Colors.black : Colors.white70,
                        ),
                        const SizedBox(width: SpacingTokens.space4),
                      ],
                      Text(
                        lens.name,
                        style: TextStyle(
                          color: chosen ? Colors.black : Colors.white,
                          fontWeight:
                              chosen ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
