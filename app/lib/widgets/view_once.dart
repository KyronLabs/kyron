// lib/widgets/view_once.dart
import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:video_player/video_player.dart';

import '../l10n/app_localizations.dart';
import '../models/conversation.dart';
import '../models/post_media.dart';
import '../providers/messages_provider.dart';
import '../services/secure_screen.dart';
import '../utils/media_basket.dart';
import 'action_button.dart';
import 'action_sheet.dart';
import 'kyron_app_bar.dart';
import 'voice_post_player.dart';

/// Fetches an opened view-once picture into memory, never to disk. A
/// provider, so a test can answer without the network.
///
/// A plain client rather than the API's: that one would send the reader's
/// session token to the storage host along with the request.
final onceBytesProvider = Provider<Future<Uint8List> Function(String url)>(
  (ref) => (url) async {
    final res = await Dio().get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(res.data ?? const []);
  },
);

/// The mark for something that opens once: a 1 in a broken ring, the way
/// the messengers that have it draw it.
class ViewOnceGlyph extends StatelessWidget {
  final double size;
  final Color? color;

  /// Drawn whole once it has been opened: the ring closes.
  final bool spent;

  const ViewOnceGlyph({
    super.key,
    this.size = 20,
    this.color,
    this.spent = false,
  });

  @override
  Widget build(BuildContext context) {
    final ink = color ?? IconTheme.of(context).color ?? Colors.white;
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _RingPainter(color: ink, broken: !spent),
        child: Center(
          child: Text(
            '1',
            style: TextStyle(
              fontSize: size * 0.55,
              height: 1,
              fontWeight: FontWeight.w800,
              color: ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  final bool broken;

  const _RingPainter({required this.color, required this.broken});

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.09;
    final rect = Offset(stroke / 2, stroke / 2) &
        Size(size.width - stroke, size.height - stroke);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    if (!broken) {
      canvas.drawOval(rect, paint);
      return;
    }
    // Eight dashes, a gap between each.
    const dashes = 8;
    const sweep = 2 * math.pi / dashes;
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(rect, i * sweep - math.pi / 2, sweep * 0.62, false, paint);
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.color != color || old.broken != broken;
}

/// Picks one photo or clip to send view once, and shows it before it goes.
///
/// Its own picker rather than the composer's: the composer uploads what is
/// picked straight away, to the public bucket, and a view-once photo must
/// never have a public copy. Nothing is uploaded until Send here.
Future<PendingMedia?> pickViewOnce(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final source = await ActionSheet.show<ImageSource>(
    context,
    title: l10n.ui('ui_once_send', 'Send view once'),
    actions: [
      SheetAction(
        value: ImageSource.gallery,
        label: l10n.literaladdAPhoto,
        icon: Iconsax.gallery_copy,
      ),
      SheetAction(
        value: ImageSource.camera,
        label: l10n.ui('ui_dm_take_photo', 'Take a photo'),
        icon: Iconsax.camera_copy,
      ),
    ],
  );
  if (source == null || !context.mounted) return null;

  final XFile? file;
  try {
    file = source == ImageSource.camera
        ? await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxWidth: 2048,
            maxHeight: 2048,
            imageQuality: 85,
          )
        : await ImagePicker().pickMedia();
  } catch (_) {
    return null;
  }
  if (file == null || !context.mounted) return null;
  final kind = mediaKindOf(file);
  // A GIF has nothing to keep private that a link to it does not already
  // give away, and the server refuses one.
  if (kind == MediaKind.gif ||
      await file.length() > MediaBasket.maxAttachmentBytes) {
    return null;
  }
  if (!context.mounted) return null;
  final pending = PendingMedia(path: file.path, kind: kind);
  final send = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _ViewOncePreview(pending: pending),
    ),
  );
  return send == true ? pending : null;
}

/// What is about to be sent view once, full screen, with what that means
/// and Send.
class _ViewOncePreview extends StatefulWidget {
  final PendingMedia pending;

  const _ViewOncePreview({required this.pending});

  @override
  State<_ViewOncePreview> createState() => _ViewOncePreviewState();
}

class _ViewOncePreviewState extends State<_ViewOncePreview> {
  VideoPlayerController? _clip;

  @override
  void initState() {
    super.initState();
    if (widget.pending.isVideo) {
      final clip = VideoPlayerController.file(File(widget.pending.path));
      _clip = clip;
      clip.initialize().then((_) {
        if (!mounted) return;
        clip
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _clip?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final clip = _clip;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: KyronAppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ViewOnceGlyph(color: Colors.white),
            const SizedBox(width: SpacingTokens.space8),
            Text(l10n.ui('ui_once_label', 'View once')),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: clip == null
                    ? Image.file(File(widget.pending.path), fit: BoxFit.contain)
                    : clip.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: clip.value.aspectRatio,
                            child: VideoPlayer(clip),
                          )
                        : const CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SpacingTokens.space16),
              child: Column(
                children: [
                  Text(
                    l10n.ui(
                      'ui_once_hint',
                      'Opens once, then it is deleted from Kyron.',
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: SpacingTokens.space12),
                  ActionButton(
                    label: l10n.send,
                    icon: Iconsax.send_1,
                    expand: true,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A view-once message, open for the one time it can be.
///
/// The open is recorded the moment this screen asks for it, and the link
/// that comes back stops working in minutes. A picture is fetched into
/// memory and never written to disk; a clip and a voice note are streamed.
/// On Android the screen cannot be captured while this is up. Closing it is
/// the end: there is no second look.
class ViewOnceViewer extends ConsumerStatefulWidget {
  final String conversationId;
  final DirectMessage message;

  /// Who sent it, for the bar at the top.
  final String? senderName;

  const ViewOnceViewer({
    super.key,
    required this.conversationId,
    required this.message,
    this.senderName,
  });

  static Future<void> open(
    BuildContext context, {
    required String conversationId,
    required DirectMessage message,
    String? senderName,
  }) =>
      Navigator.of(context, rootNavigator: true).push<void>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => ViewOnceViewer(
            conversationId: conversationId,
            message: message,
            senderName: senderName,
          ),
        ),
      );

  @override
  ConsumerState<ViewOnceViewer> createState() => _ViewOnceViewerState();
}

class _ViewOnceViewerState extends ConsumerState<ViewOnceViewer> {
  OpenedOnce? _opened;
  MemoryImage? _image;
  VideoPlayerController? _clip;

  /// Why it would not open: the server's status, or 0 for anything else.
  /// Put into words in [build], where the language is known.
  int? _failure;

  @override
  void initState() {
    super.initState();
    SecureScreen.hold();
    _load();
  }

  @override
  void dispose() {
    SecureScreen.release();
    _clip?.dispose();
    // Out of the decoded-image cache too, not only off the screen.
    final image = _image;
    if (image != null) PaintingBinding.instance.imageCache.evict(image);
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final opened = await ref
          .read(threadProvider(widget.conversationId).notifier)
          .openOnce(widget.message);
      if (!mounted) return;
      switch (opened.kind) {
        case MediaKind.video:
          final clip = VideoPlayerController.networkUrl(Uri.parse(opened.url));
          await clip.initialize();
          if (!mounted) {
            await clip.dispose();
            return;
          }
          _clip = clip;
          await clip.play();
        case MediaKind.voice:
          break;
        default:
          final bytes = await ref.read(onceBytesProvider)(opened.url);
          if (!mounted) return;
          _image = MemoryImage(bytes);
      }
      setState(() => _opened = opened);
    } on DioException catch (error) {
      if (mounted) setState(() => _failure = error.response?.statusCode ?? 0);
    } catch (_) {
      if (mounted) setState(() => _failure = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: KyronAppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle_copy),
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ViewOnceGlyph(size: 18, color: Colors.white),
            const SizedBox(width: SpacingTokens.space8),
            Flexible(
              child: Text(
                widget.senderName ?? l10n.ui('ui_once_label', 'View once'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(child: Center(child: _content(context))),
    );
  }

  Widget _content(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final failure = _failure;
    if (failure != null) {
      final problem = switch (failure) {
        410 => l10n.ui('ui_once_already', 'This has already been opened.'),
        403 => l10n.ui(
            'ui_once_own',
            'Only the people you sent this to can open it, once.',
          ),
        _ => l10n.ui('ui_once_failed', 'This could not be opened.'),
      };
      return Padding(
        padding: const EdgeInsets.all(SpacingTokens.space24),
        child: Text(
          problem,
          key: const ValueKey('once-problem'),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      );
    }
    final opened = _opened;
    if (opened == null) return const CircularProgressIndicator();

    final clip = _clip;
    if (clip != null) {
      return GestureDetector(
        onTap: () => setState(
          () => clip.value.isPlaying ? clip.pause() : clip.play(),
        ),
        child: AspectRatio(
          aspectRatio: clip.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(clip),
              VideoProgressIndicator(clip, allowScrubbing: false),
            ],
          ),
        ),
      );
    }
    final image = _image;
    if (image != null) {
      return InteractiveViewer(
        child: Image(image: image, fit: BoxFit.contain, gaplessPlayback: true),
      );
    }
    // A voice note: the same player as anywhere else, from a link that runs
    // out a minute after the note does.
    return Padding(
      padding: const EdgeInsets.all(SpacingTokens.space24),
      child: Theme(
        data: ThemeData.dark(),
        child: VoicePostPlayer(
          media: PostMedia(
            id: widget.message.id,
            kind: MediaKind.voice,
            url: opened.url,
            duration: opened.duration ?? widget.message.once?.duration,
            waveform: opened.waveform.isNotEmpty
                ? opened.waveform
                : widget.message.once?.waveform ?? const [],
          ),
        ),
      ),
    );
  }
}
