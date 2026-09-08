// lib/screens/ar_lens_screen.dart
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

import '../models/lens.dart';
import '../models/post_media.dart';
import '../providers/composer_provider.dart';
import '../services/app_log.dart';
import '../services/lens_renderer.dart';
import '../widgets/empty_state.dart';

/// The camera, with a lens over it.
///
/// This replaces `ComingSoonScreen.arLens()`, which said lenses were not built
/// and kept the camera closed -- which was honest at the time.
///
/// What a "lens" is here is a colour transform, applied to the live preview
/// and baked into the file by the same matrix, so the picture taken is the
/// picture seen. It is not face tracking and does not put a hat on anybody;
/// see docs/AR.md for where the line is.
class ArLensScreen extends ConsumerStatefulWidget {
  const ArLensScreen(
      {super.key, this.cameras, this.renderer = const LensRenderer()});

  /// Injected by tests. Null means ask the platform, which is what the app
  /// does; an empty list is a device with no camera, which is a state this
  /// screen has to render rather than crash on.
  final List<CameraDescription>? cameras;

  final LensRenderer renderer;

  @override
  ConsumerState<ArLensScreen> createState() => _ArLensScreenState();
}

class _ArLensScreenState extends ConsumerState<ArLensScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  int _cameraIndex = 0;

  Lens _lens = Lens.all.first;
  bool _opening = true;
  bool _capturing = false;
  String? _problem;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _open();
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
    if (_lens.filter == null) return shot.path;

    final bytes = await shot.readAsBytes();
    final decoded = await _decode(bytes);
    final filtered = await widget.renderer.apply(decoded, _lens);
    final png = await widget.renderer.encode(filtered);

    final directory = await getTemporaryDirectory();
    final path = p.join(
      directory.path,
      'lens_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await File(path).writeAsBytes(png, flush: true);
    return path;
  }

  Future<ui.Image> _decode(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
              selected: _lens,
              onChanged: (lens) => setState(() => _lens = lens),
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

    return Center(
      child: AspectRatio(
        aspectRatio: 1 / controller.value.aspectRatio,
        child: filter == null
            ? preview
            : ColorFiltered(colorFilter: filter, child: preview),
      ),
    );
  }

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
  final Lens selected;
  final ValueChanged<Lens> onChanged;

  const _LensStrip({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space16),
        itemCount: Lens.all.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: SpacingTokens.space8),
        itemBuilder: (context, index) {
          final lens = Lens.all[index];
          final chosen = lens.id == selected.id;

          return Center(
            child: GestureDetector(
              onTap: () => onChanged(lens),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingTokens.space16,
                  vertical: SpacingTokens.space8,
                ),
                decoration: BoxDecoration(
                  color: chosen ? Colors.white : Colors.white12,
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
                ),
                child: Text(
                  lens.name,
                  style: TextStyle(
                    color: chosen ? Colors.black : Colors.white,
                    fontWeight: chosen ? FontWeight.w600 : FontWeight.w400,
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
