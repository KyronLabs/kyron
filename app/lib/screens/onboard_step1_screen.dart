// lib/screens/onboard_step1_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';

import '../services/profile_service.dart';

import 'package:image_picker/image_picker.dart';

import '../models/onboarding_model.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/api_error_message.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';
import '../widgets/camera_tooltip_menu.dart';
import '../widgets/gradient_scaffold.dart';

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

  /* ---------- helpers ---------- */
  bool get _canProceed => _nameCtrl.text.trim().isNotEmpty;

  /* ---------- image pickers ---------- */
  Future<void> _pickAvatar() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) setState(() => widget.model.localAvatarPath = file.path);
  }

  Future<void> _pickCover() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) setState(() => widget.model.localCoverPath = file.path);
  }

  /* ---------- AI / random helpers ---------- */
  void _generateAIAvatar() => debugPrint('TODO: AI avatar generation');
  void _randomiseCover() async {
    if (_isLoading) return;
    try {
      setState(() => _isLoading = true);
      await _profileService.randomCover();
    } catch (e) {
      debugPrint('randomiseCover failed: $e');
      _report(describeApiError(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /* ---------- navigation ---------- */
  void _report(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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
        );
      } catch (e) {
        debugPrint('step1: updateProfile failed: $e');
        _report(describeApiError(e));
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
          _report('Photo not uploaded: ${describeApiError(e)}');
        }
      }

      if (widget.model.localCoverPath != null) {
        try {
          await _profileService.uploadCover(File(widget.model.localCoverPath!));
        } catch (e) {
          debugPrint('step1: cover upload failed: $e');
          _report('Cover not uploaded: ${describeApiError(e)}');
        }
      } else {
        // Picking a random default cover is a nicety, and it is the call most
        // likely to fail: it reads a storage folder that may not exist yet.
        // Silently skip it rather than stranding the user.
        try {
          await _profileService.randomCover();
        } catch (e) {
          debugPrint('step1: randomCover failed (ignored): $e');
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return GradientScaffold(
      appBar: AppBar(title: const Text('Create your profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          children: [
            /* ---------- COVER + AVATAR ----------
               One stack, explicitly sized to the cover plus the part of the
               avatar that hangs below it. The avatar used to be a sibling
               shifted up with Transform.translate, which moves paint but not
               layout, so it reserved its full height and left a gap under it. */
            SizedBox(
              height: 200 + 64,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /* cover image or placeholder */
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: widget.model.localCoverPath != null
                              ? Image.file(
                                  File(widget.model.localCoverPath!),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: isDark
                                      ? AppTheme.surface
                                      : AppTheme.lightSurface,
                                  child: Center(
                                    child: Icon(
                                      Icons.add_photo_alternate,
                                      size: 56,
                                      color: scheme.onSurface.withValues(
                                        alpha: .35,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: CameraTooltipMenu(
                            onGallery: _pickCover,
                            onSecondary: _randomiseCover,
                            secondaryLabel: 'Randomise',
                            secondaryIcon: Icons.shuffle,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /* avatar, straddling the bottom edge of the cover */
                  Positioned(
                    top: 200 - 64,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        width: 128,
                        height: 128,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: isDark
                                  ? AppTheme.surface
                                  : AppTheme.lightSurface,
                              backgroundImage:
                                  widget.model.localAvatarPath != null
                                  ? FileImage(
                                      File(widget.model.localAvatarPath!),
                                    )
                                  : null,
                              child: widget.model.localAvatarPath == null
                                  ? Icon(
                                      Icons.person,
                                      size: 64,
                                      color: scheme.onSurface.withValues(
                                        alpha: .45,
                                      ),
                                    )
                                  : null,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: CameraTooltipMenu(
                                onGallery: _pickAvatar,
                                onSecondary: _generateAIAvatar,
                                secondaryLabel: 'Generate AI',
                                secondaryIcon: Icons.auto_awesome,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /* ---------- TEXT FIELDS ---------- */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppInputField(
                    hint: 'Display name',
                    controller: _nameCtrl,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    hint: 'Bio (optional)',
                    controller: _bioCtrl,
                    maxLines: 3,
                    maxLength: 160,
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    label: 'Continue',
                    isLoading: _isLoading,
                    enabled: _canProceed,
                    onTap: _next,
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
