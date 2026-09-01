// lib/screens/edit_profile_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/current_user_provider.dart';
import '../providers/profile_provider.dart';
import '../services/profile_service.dart';
import '../utils/api_error_message.dart';

/// Editing your own profile: the name, bio, location, website and the two
/// images. The "Edit profile" button used to lead nowhere.
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _form = GlobalKey<FormState>();
  final _service = ProfileService();
  final _picker = ImagePicker();

  final _name = TextEditingController();
  final _bio = TextEditingController();
  final _location = TextEditingController();
  final _website = TextEditingController();

  bool _prefilled = false;
  bool _saving = false;
  String? _uploading;

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    _location.dispose();
    _website.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Edit profile'),
        actions: [
          TextButton(
            onPressed: _saving || !state.hasValue ? null : _save,
            child: _saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _Failed(
          message: describeApiError(e, sessionIsLive: true),
          onRetry: () => ref.read(currentUserProvider.notifier).refresh(),
        ),
        data: (user) {
          // Prefill once. Doing it on every build would overwrite whatever is
          // being typed each time the provider emits.
          if (!_prefilled) {
            _prefilled = true;
            _name.text = user.name ?? '';
            _bio.text = user.bio ?? '';
            _location.text = user.location ?? '';
            _website.text = user.website ?? '';
          }

          return SafeArea(
            child: Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.all(SpacingTokens.space20),
                children: [
                  _ImageRow(
                    avatarUrl: user.avatarUrl,
                    coverUrl: user.coverUrl,
                    uploading: _uploading,
                    onPickAvatar: () => _upload('avatar'),
                    onPickCover: () => _upload('cover'),
                  ),
                  const SizedBox(height: SpacingTokens.space24),
                  _field(_name, 'Display name', Iconsax.user_copy,
                      maxLength: 50),
                  const SizedBox(height: SpacingTokens.space16),
                  _field(_bio, 'Bio', Iconsax.note_text_copy,
                      maxLength: 300, maxLines: 4),
                  const SizedBox(height: SpacingTokens.space16),
                  _field(_location, 'Location', Iconsax.location_copy,
                      maxLength: 80),
                  const SizedBox(height: SpacingTokens.space16),
                  _field(
                    _website,
                    'Website',
                    Iconsax.link_copy,
                    maxLength: 200,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return null;
                      final uri = Uri.tryParse(
                        text.contains('://') ? text : 'https://$text',
                      );
                      return uri != null && uri.host.contains('.')
                          ? null
                          : 'That does not look like a web address';
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    int? maxLength,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18),
      ),
    );
  }

  Future<void> _upload(String kind) async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: kind == 'cover' ? 1600 : 800,
    );
    if (picked == null) return;

    setState(() => _uploading = kind);
    try {
      final file = File(picked.path);
      if (kind == 'avatar') {
        await _service.uploadAvatar(file);
      } else {
        await _service.uploadCover(file);
      }
      // Re-read rather than patching locally: the URL comes from storage, and
      // guessing it is how a stale image ends up cached forever.
      ref.read(currentUserProvider.notifier).refresh();
      ref.read(profileProvider(null).notifier).load(force: true);
    } catch (e) {
      _report(describeApiError(e, sessionIsLive: true));
    } finally {
      if (mounted) setState(() => _uploading = null);
    }
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false)) return;

    setState(() => _saving = true);
    try {
      await _service.updateProfile(
        name: _name.text.trim(),
        bio: _bio.text.trim(),
        location: _location.text.trim(),
        website: _website.text.trim(),
      );
      ref.read(currentUserProvider.notifier).refresh();
      ref.read(profileProvider(null).notifier).load(force: true);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
    } catch (e) {
      _report(describeApiError(e, sessionIsLive: true));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _report(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ImageRow extends StatelessWidget {
  final String? avatarUrl;
  final String? coverUrl;
  final String? uploading;
  final VoidCallback onPickAvatar;
  final VoidCallback onPickCover;

  const _ImageRow({
    required this.avatarUrl,
    required this.coverUrl,
    required this.uploading,
    required this.onPickAvatar,
    required this.onPickCover,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        InkWell(
          onTap: uploading == null ? onPickCover : null,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
              image: coverUrl == null
                  ? null
                  : DecorationImage(
                      image: NetworkImage(coverUrl!),
                      fit: BoxFit.cover,
                    ),
            ),
            child: Center(
              child: uploading == 'cover'
                  ? const CircularProgressIndicator()
                  : Icon(Iconsax.gallery_edit_copy,
                      color: scheme.onSurface.withValues(alpha: 0.7)),
            ),
          ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        InkWell(
          onTap: uploading == null ? onPickAvatar : null,
          borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: scheme.primary.withValues(alpha: 0.2),
            foregroundImage:
                avatarUrl == null ? null : NetworkImage(avatarUrl!),
            child: uploading == 'avatar'
                ? const CircularProgressIndicator()
                : Icon(Iconsax.camera_copy, color: scheme.primary),
          ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          'Tap to change',
          style: TextStyle(
            fontSize: 12,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _Failed extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _Failed({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: SpacingTokens.space16),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
