import '../l10n/app_localizations.dart';
// lib/screens/onboard_step1_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';

import '../services/profile_service.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../models/onboarding_model.dart';
import '../repositories/auth_repository.dart';
import '../routes.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import '../utils/api_error_message.dart';
import '../widgets/app_button.dart';
import '../widgets/action_sheet.dart';
import '../widgets/images_field.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/kyron_app_bar.dart';

class OnboardStep1Screen extends StatefulWidget {
  final OnboardingModel model;
  const OnboardStep1Screen({super.key, required this.model});

  @override
  State<OnboardStep1Screen> createState() => _OnboardStep1ScreenState();
}

class _OnboardStep1ScreenState extends State<OnboardStep1Screen> {
  bool _isLoading = false;

  /* ---------- controllers ---------- */
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _bioCtrl = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _profileService = ProfileService();
  final _authRepository = AuthRepository();

  /// Whether Supabase still holds a valid session for this device. A 401 while
  /// this is true is the server refusing a good token, not an expired sign-in,
  /// and telling the two apart is what stops "Session expired" sending people
  /// back to a login screen that cannot help them.
  bool get _sessionIsLive => _authRepository.hasValidSession;

  /* ---------- helpers ---------- */
  bool get _canProceed => _nameCtrl.text.trim().isNotEmpty;

  /* ---------- image pickers ---------- */
  Future<void> _pickAvatar() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) setState(() => widget.model.localAvatarPath = file.path);
  }

  /// The cover has two sources, so it asks. A sheet rather than the tooltip
  /// menu this replaced: a popup opens wherever the button happens to be and
  /// its rows are too small to hit on a phone, and Kyron's menus are sheets
  /// everywhere else.
  Future<void> _chooseCover() async {
    final choice = await ActionSheet.show<_CoverSource>(
      context,
      title: AppLocalizations.of(context).literalcoverPhoto,
      actions: const [
        SheetAction(
          value: _CoverSource.gallery,
          label: AppLocalizations.of(context).literalchooseFromGallery,
          icon: Iconsax.gallery_copy,
        ),
        SheetAction(
          value: _CoverSource.random,
          label: AppLocalizations.of(context).literaluseOneOfOurs,
          icon: Iconsax.shuffle_copy,
          detail: 'A picture from Kyron, if you have not got one in mind',
        ),
      ],
    );

    switch (choice) {
      case _CoverSource.gallery:
        await _pickCover();
      case _CoverSource.random:
        await _randomiseCover();
      case null:
        break;
    }
  }

  Future<void> _pickCover() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => widget.model.chooseLocalCover(file.path));
    }
  }

  Future<void> _randomiseCover() async {
    if (_isLoading) return;
    try {
      setState(() => _isLoading = true);
      final url = await _profileService.randomCover();
      if (!mounted) return;
      if (url == null) {
        // Storage holds no default covers, so there is nothing to pick.
        // Saying so beats a button that appears to do nothing.
        _report('No default covers are available yet.');
        return;
      }
      setState(() => widget.model.chooseRemoteCover(url));
    } catch (e) {
      debugPrint('randomiseCover failed: $e');
      _report(describeApiError(e, sessionIsLive: _sessionIsLive));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /* ---------- navigation ---------- */
  void _report(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _next() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      widget.model.displayName = _nameCtrl.text.trim();
      widget.model.bio = _bioCtrl.text.trim();

      // Essential. If the profile itself cannot be saved there is nothing to
      // carry forward, so this is the only failure that stops the flow.
      try {
        await _profileService.updateProfile(
          name: widget.model.displayName,
          bio: widget.model.bio.isEmpty ? null : widget.model.bio,
          // Persist the cover the user actually saw. _next() used to call
          // randomCover() here instead, which only fetched a URL and discarded
          // it -- saving nothing, and liable to roll a different cover than
          // the one previewed.
          coverUrl: widget.model.remoteCoverUrl,
        );
      } catch (e) {
        debugPrint('step1: updateProfile failed: $e');
        _report(describeApiError(e, sessionIsLive: _sessionIsLive));
        return;
      }

      // Everything below is decoration. It used to sit in the same try as the
      // profile save, under a catch that only debugPrinted -- so a failing
      // image upload or cover lookup left the user on this screen with no
      // message and no way forward. Each is now allowed to fail on its own
      // without trapping anyone here.
      if (widget.model.localAvatarPath != null) {
        try {
          await _profileService.uploadAvatar(
            File(widget.model.localAvatarPath!),
          );
        } catch (e) {
          debugPrint('step1: avatar upload failed: $e');
          _report(
            'Photo not uploaded: '
            '${describeApiError(e, sessionIsLive: _sessionIsLive)}',
          );
        }
      }

      if (widget.model.localCoverPath != null) {
        try {
          await _profileService.uploadCover(File(widget.model.localCoverPath!));
        } catch (e) {
          debugPrint('step1: cover upload failed: $e');
          _report(
            'Cover not uploaded: '
            '${describeApiError(e, sessionIsLive: _sessionIsLive)}',
          );
        }
      }

      if (!mounted) return;
      Navigator.pushNamed(
        context,
        Routes.onboardStep2,
        arguments: widget.model,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = widget.model.localAvatarPath;
    final cover = widget.model.localCoverPath;

    return GradientScaffold(
      appBar: KyronAppBar(
        title: Text(AppLocalizations.of(context).createYourProfile),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SpacingTokens.space20),
          children: [
            // The same pair, in the same arrangement, as Edit profile. What
            // this replaced was a 200-pixel banner with a 128-pixel avatar
            // straddling it -- a header, drawn on a form, taking most of the
            // screen before a word could be typed. The two screens edit the
            // same two pictures and now look like it.
            ImagesField(
              avatarUrl: null,
              coverUrl: widget.model.remoteCoverUrl,
              avatarFile: avatar == null ? null : File(avatar),
              coverFile: cover == null ? null : File(cover),
              uploading: _isLoading ? ImageSlot.cover : null,
              onPickAvatar: _pickAvatar,
              onPickCover: _chooseCover,
              hint: AppLocalizations.of(context).literaltapToAddAPhotoAndACover,
            ),
            const SizedBox(height: SpacingTokens.space24),
            _field(
              _nameCtrl,
              'Display name',
              Iconsax.user_copy,
              maxLength: 50,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: SpacingTokens.space16),
            _field(
              _bioCtrl,
              'Bio',
              Iconsax.note_text_copy,
              maxLength: 160,
              maxLines: 4,
            ),
            const SizedBox(height: SpacingTokens.space32),
            AppButton(
              label: AppLocalizations.of(context).continueAction,
              isLoading: _isLoading,
              enabled: _canProceed,
              onTap: _next,
            ),
          ],
        ),
      ),
    );
  }

  /// Edit profile's field, so the two read the same: a label rather than a
  /// hint that vanishes as soon as anybody types, and an icon that says what
  /// the row is for.
  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    int? maxLength,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        // Pinned to the top of a field that grows, rather than floating in
        // the middle of an empty bio box.
        prefixIcon: _prefix(context, icon, maxLines),
      ),
    );
  }

  Widget _prefix(BuildContext context, IconData icon, int maxLines) {
    final child = Icon(icon, size: 20);
    if (maxLines == 1) return child;
    return Align(
      alignment: Alignment.topLeft,
      widthFactor: 1,
      heightFactor: 1,
      child: Padding(
        padding: const EdgeInsets.only(
          left: SpacingTokens.space12,
          top: SpacingTokens.space16,
          right: SpacingTokens.space8,
        ),
        child: child,
      ),
    );
  }
}

/// Where a cover comes from.
enum _CoverSource { gallery, random }
