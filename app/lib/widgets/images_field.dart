// lib/widgets/images_field.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// Which of the two is being uploaded right now.
enum ImageSlot { avatar, cover }

/// The banner and the round picture above a form, both of them tappable.
///
/// One widget for the profile and for a community. They are the same pair of
/// pictures in the same arrangement, and the community's used to be two boxes
/// asking for a URL -- which is not something anybody has for a photograph on
/// their phone.
class ImagesField extends StatelessWidget {
  final String? avatarUrl;
  final String? coverUrl;

  /// A picture chosen on this device and not uploaded yet, which is what
  /// creating a profile looks like: there is no URL to show until the account
  /// exists. Shown in preference to the URL when set, so the reader sees what
  /// they just picked rather than what the server still has.
  final File? avatarFile;
  final File? coverFile;

  /// Set while one of them is going up, so the other cannot be started and the
  /// one in flight shows a spinner over whatever is already there.
  final ImageSlot? uploading;

  final VoidCallback onPickAvatar;
  final VoidCallback onPickCover;

  /// The line under the pair. Says what tapping does, since neither picture
  /// looks like a button once it has an image in it.
  final String hint;

  /// Height of the banner. A community's is wider than it is tall by more than
  /// a profile's, because it is drawn behind a header rather than above one.
  final double coverHeight;

  const ImagesField({
    super.key,
    required this.avatarUrl,
    required this.coverUrl,
    required this.uploading,
    this.avatarFile,
    this.coverFile,
    required this.onPickAvatar,
    required this.onPickCover,
    this.hint = 'Tap to change',
    this.coverHeight = 120,
  });

  /// The file first, because it is the newer of the two: somebody who has
  /// just picked a photograph should see that one, not the one still on the
  /// server.
  ImageProvider? get _avatar => _pick(avatarFile, avatarUrl);

  ImageProvider? get _cover => _pick(coverFile, coverUrl);

  static ImageProvider? _pick(File? file, String? url) {
    if (file != null) return FileImage(file);
    if (url != null) return NetworkImage(url);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final busy = uploading != null;

    return Column(
      children: [
        InkWell(
          onTap: busy ? null : onPickCover,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          child: Container(
            height: coverHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
              image: _cover == null
                  ? null
                  : DecorationImage(image: _cover!, fit: BoxFit.cover),
            ),
            child: Center(
              child: uploading == ImageSlot.cover
                  ? const CircularProgressIndicator()
                  // Hidden once there is a picture: an icon over somebody's
                  // own photograph is in the way, and the line underneath
                  // already says the pair can be tapped.
                  : _cover != null
                  ? const SizedBox.shrink()
                  : Icon(
                      Iconsax.gallery_edit_copy,
                      color: scheme.onSurface.withValues(alpha: 0.7),
                    ),
            ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        InkWell(
          onTap: busy ? null : onPickAvatar,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: scheme.primary.withValues(alpha: 0.2),
            foregroundImage: _avatar,
            child: uploading == ImageSlot.avatar
                ? const CircularProgressIndicator()
                : _avatar != null
                ? null
                : Icon(Iconsax.camera_copy, color: scheme.primary),
          ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          hint,
          style: TextStyle(
            fontSize: TypographyTokens.fontSize1,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
