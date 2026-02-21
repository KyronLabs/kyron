// lib/screens/onboard_step1_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../services/profile_service.dart';
import 'package:image_picker/image_picker.dart';
import '../models/onboarding_model.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
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
  } catch (_) {}
  finally {
    if (mounted) setState(() => _isLoading = false);
  }
  }

  /* ---------- navigation ---------- */
  Future<void> _next() async {
  if (_isLoading) return;
  setState(() => _isLoading = true);

  try {
    debugPrint('⚡ STEP1 START');

    widget.model.displayName = _nameCtrl.text.trim();
    widget.model.bio = _bioCtrl.text.trim();

    debugPrint('⚡ updating profile text...');
    await _profileService.updateProfile(
      name: widget.model.displayName,
      bio: widget.model.bio.isEmpty ? null : widget.model.bio,
    );

    if (widget.model.localAvatarPath != null) {
      debugPrint('⚡ uploading avatar...');
      await _profileService.uploadAvatar(File(widget.model.localAvatarPath!));
    }

    if (widget.model.localCoverPath != null) {
      debugPrint('⚡ uploading cover...');
      await _profileService.uploadCover(File(widget.model.localCoverPath!));
    } else {
      debugPrint('⚡ randomizing cover...');
      await _profileService.randomCover();
    }

    debugPrint('⚡ DONE! now navigating…');

    if (mounted) {
      await Future.delayed(const Duration(milliseconds: 100));
      debugPrint('⚡ pushing onboard2');
      Navigator.pushNamed(
        context,
        Routes.onboardStep2,
        arguments: widget.model,
      );
    }
  } catch (e, s) {
    debugPrint('❌ ERROR IN STEP1: $e');
    debugPrint(s.toString());
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
            /* ---------- COVER SECTION ---------- */
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  /* cover image or placeholder */
                  Positioned.fill(
                    child: widget.model.localCoverPath != null
                        ? Image.file(File(widget.model.localCoverPath!),
                            fit: BoxFit.cover)
                        : Container(
                            color:
                                isDark ? AppTheme.surface : AppTheme.lightSurface,
                            child: Center(
                              child: Icon(Icons.add_photo_alternate,
                                  size: 56,
                                  color: scheme.onSurface.withValues(alpha: .35)),
                            ),
                          ),
                  ),

                  /* translucent camera button with tooltip menu */
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

            /* ---------- AVATAR SECTION (overlaps cover) ---------- */
            Transform.translate(
              offset: const Offset(0, -40),
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          isDark ? AppTheme.surface : AppTheme.lightSurface,
                      backgroundImage: widget.model.localAvatarPath != null
                          ? FileImage(File(widget.model.localAvatarPath!))
                          : null,
                      child: widget.model.localAvatarPath == null
                          ? Icon(Icons.person,
                              size: 64,
                              color: scheme.onSurface.withValues(alpha: .45))
                          : null,
                    ),

                    /* translucent camera button with tooltip menu */
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
  onTap: () {
    if (!_canProceed || _isLoading) return;
    _next();
  },
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
