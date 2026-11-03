// lib/widgets/reply_bar.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/post_media.dart';
import 'hairline.dart';
import 'media_tray.dart';

/// The box a reply is written in, at the foot of a post or a comment.
///
/// Laid out as people expect a reply box to be: add a photo or clip on the
/// left, the field in a pill with the GIF button at its end, and a round
/// Send beside it with room between them. It was a pill with the gallery
/// and GIF crammed inside its end and a bare arrow hard against the screen
/// edge. Both reply screens used to draw their own: two
/// full-size icon buttons in front of a form field that took the theme's
/// filled box, its 44-point floor and its blue focus ring -- a form control
/// with a toolbar bolted to it, for a box that usually holds a sentence.
/// One widget, so the post's page and a comment's page cannot drift apart.
class ReplyBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final String hintText;

  /// Whether Send does anything. Decided by the screen, which knows whether
  /// an upload is still running.
  final bool canSend;
  final bool sending;
  final VoidCallback onSend;

  /// Whether another attachment fits.
  final bool canAttach;

  /// Photos and clips, from one gallery picker.
  final VoidCallback onAddMedia;
  final VoidCallback onAddGif;

  final List<PendingMedia> media;
  final void Function(String path) onRemoveMedia;
  final void Function(String path) onRetryMedia;
  final void Function(PendingMedia item) onDescribeMedia;

  /// Who is being answered, when it is not the thing the page is about.
  final String? replyingTo;
  final VoidCallback? onCancelReply;

  /// The server's limit on a reply.
  final int maxLength;

  /// Called as the text changes, so the screen can rebuild what depends on it.
  final ValueChanged<String>? onChanged;

  const ReplyBar({
    super.key,
    required this.controller,
    required this.focus,
    required this.hintText,
    required this.canSend,
    required this.sending,
    required this.onSend,
    required this.canAttach,
    required this.onAddMedia,
    required this.onAddGif,
    required this.media,
    required this.onRemoveMedia,
    required this.onRetryMedia,
    required this.onDescribeMedia,
    this.replyingTo,
    this.onCancelReply,
    this.maxLength = 500,
    this.onChanged,
  });

  /// How tall the empty field is: one line of text and its padding.
  static const double fieldHeight = 40;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    // A small, tight button: the field is one line of text tall, and a
    // standard 48-point button beside it would set the height of the bar.
    Widget button({
      required IconData icon,
      required String tooltip,
      required VoidCallback? onPressed,
      double size = 20,
      double width = 32,
      Color? color,
    }) =>
        IconButton(
          onPressed: onPressed,
          tooltip: tooltip,
          icon: Icon(icon, size: size),
          color: color,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          // Without this the button reserves a 48-point target around its
          // own box, and two of them side by side sat that far apart: the
          // gap between the picture and the clip buttons.
          style: const ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          constraints: BoxConstraints.tightFor(
            width: width,
            height: fieldHeight,
          ),
        );

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: postRule(scheme)),
      ),
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space8,
        SpacingTokens.space8,
        SpacingTokens.space12,
        SpacingTokens.space8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (replyingTo != null)
            Padding(
              padding: const EdgeInsets.only(
                left: SpacingTokens.space4,
                bottom: SpacingTokens.space4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Replying to $replyingTo',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TypographyTokens.fontSize1,
                        fontWeight: FontWeight.w600,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  // As small as the line it sits on. A full-size button here
                  // made a line of eleven-point text forty points tall.
                  SizedBox.square(
                    dimension: 24,
                    child: IconButton(
                      onPressed: onCancelReply,
                      tooltip: l10n.literalcancelReply,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Iconsax.close_circle_copy,
                        size: 16,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (media.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
              child: MediaTray(
                media: media,
                height: 84,
                onRemove: onRemoveMedia,
                onRetry: onRetryMedia,
                onDescribe: onDescribeMedia,
              ),
            ),
          Row(
            // The buttons stay on the last line as the field grows.
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Photos and clips, outside the box: a thing you add to the
              // reply, not a thing you type into it.
              button(
                icon: Iconsax.gallery_add_copy,
                tooltip: l10n.ui('ui_add_photo_or_clip', 'Add a photo or clip'),
                onPressed: canAttach ? onAddMedia : null,
                size: 22,
                width: 40,
              ),
              const SizedBox(width: SpacingTokens.space4),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: fieldHeight),
                  padding: const EdgeInsets.only(
                    left: SpacingTokens.space16,
                    right: SpacingTokens.space4,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(RadiusTokens.radius20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focus,
                          minLines: 1,
                          maxLines: 4,
                          maxLength: maxLength,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: onChanged,
                          style: const TextStyle(
                            fontSize: TypographyTokens.fontSize3,
                            height: TypographyTokens.lineHeightSnug,
                          ),
                          decoration: InputDecoration(
                            hintText: hintText,
                            counterText: '',
                            isDense: true,
                            // The pill around it is the shape. Every border
                            // is named because the theme's focused border is
                            // an accent outline, and naming only `border`
                            // leaves that one in place.
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            // No floor: the theme's minimum height is what
                            // made an empty box taller than the line in it.
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                      // GIF inside the box, at its end, and there whether or
                      // not something is being written: a GIF goes with
                      // words as often as instead of them.
                      button(
                        icon: Iconsax.emoji_happy_copy,
                        tooltip: l10n.literaladdAGif,
                        onPressed: canAttach ? onAddGif : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              _SendButton(
                sending: sending,
                tooltip: l10n.send,
                onPressed: canSend ? onSend : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Send, as a filled round button beside the field: plainly a button, and
/// plainly off until there is something to send.
class _SendButton extends StatelessWidget {
  final bool sending;
  final String tooltip;
  final VoidCallback? onPressed;

  const _SendButton({
    required this.sending,
    required this.tooltip,
    required this.onPressed,
  });

  static const double size = ReplyBar.fieldHeight;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final on = onPressed != null && !sending;
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        enabled: on,
        label: tooltip,
        excludeSemantics: true,
        child: Material(
          color: on ? scheme.primary : scheme.surfaceContainerHigh,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: on ? onPressed : null,
            child: SizedBox.square(
              dimension: size,
              child: Center(
                child: sending
                    ? SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      )
                    : Icon(
                        Iconsax.send_1,
                        size: 20,
                        color: on
                            ? scheme.onPrimary
                            : scheme.onSurface.withValues(alpha: 0.35),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
