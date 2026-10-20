// lib/screens/choose_handle_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/handle_check.dart';
import '../providers/auth_provider.dart';
import '../providers/current_user_provider.dart';
import '../providers/profile_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/app_button.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/kyron_app_bar.dart';

/// Picking a handle, for an account that has none.
///
/// Accounts made through Google never had one: Google sends no username, and
/// nothing asked. Neither did an email sign-up that left the box empty, or
/// asked for one somebody already had -- that one was dropped without a word.
/// Until this there was no way to set one afterwards, so those accounts had
/// no @name to be found or mentioned by.
///
/// Shown once, between onboarding and the app, until a handle is chosen.
class ChooseHandleScreen extends ConsumerStatefulWidget {
  /// The account's display name, which the first suggestion is made from.
  final String? name;

  const ChooseHandleScreen({super.key, this.name});

  /// How long typing has to pause before the server is asked.
  static const debounce = Duration(milliseconds: 350);

  /// A starting point from a display name: lowercase, spaces as
  /// underscores, and nothing the rule would refuse.
  static String suggestionFrom(String? name) {
    final slug = (name ?? '')
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^a-z0-9_]'), '');
    final cut = slug.length > 30 ? slug.substring(0, 30) : slug;
    return cut.length >= 2 ? cut : '';
  }

  @override
  ConsumerState<ChooseHandleScreen> createState() => _ChooseHandleScreenState();
}

class _ChooseHandleScreenState extends ConsumerState<ChooseHandleScreen> {
  late final _handle = TextEditingController(
    text: ChooseHandleScreen.suggestionFrom(widget.name),
  );

  /// The answer for what is in the box now, or null while it is being asked.
  HandleCheck? _check;
  bool _checking = false;
  bool _saving = false;
  String? _error;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (_handle.text.isNotEmpty) _scheduleCheck();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _handle.dispose();
    super.dispose();
  }

  void _scheduleCheck() {
    _debounce?.cancel();
    setState(() {
      _check = null;
      _error = null;
      _checking = _handle.text.length >= 2;
    });
    if (_handle.text.length < 2) return;
    _debounce = Timer(ChooseHandleScreen.debounce, _runCheck);
  }

  Future<void> _runCheck() async {
    final asked = _handle.text;
    try {
      final check =
          await ref.read(profileRepositoryProvider).handleAvailability(asked);
      // Typing moved on while this was in flight: its answer is for a
      // handle that is no longer in the box.
      if (!mounted || _handle.text != asked) return;
      setState(() {
        _check = check;
        _checking = false;
      });
    } catch (error) {
      if (!mounted || _handle.text != asked) return;
      setState(() {
        _checking = false;
        _error = describeApiError(error, sessionIsLive: true);
      });
    }
  }

  Future<void> _choose() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(profileRepositoryProvider).chooseHandle(_handle.text);
      // The gate above this screen watches the account: once it has a handle
      // the app opens.
      await ref.read(currentUserProvider.notifier).load(force: true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = describeApiError(error, sessionIsLive: true);
      });
      // Most likely taken between the check and the press.
      unawaited(_runCheck());
    }
  }

  String? get _status {
    if (_handle.text.length < 2) return 'At least 2 characters.';
    if (_checking || _check == null) return 'Checking…';
    if (_check!.available) return '@${_check!.handle} is yours if you want it.';
    return switch (_check!.reason) {
      'taken' => '@${_check!.handle} is taken.',
      'reserved' => '@${_check!.handle} is reserved. Try another.',
      _ => 'Lowercase letters, numbers and underscores only.',
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final free = _check?.available ?? false;
    final faint = scheme.onSurface.withValues(alpha: .6);

    return GradientScaffold(
      appBar: const KyronAppBar(title: Text('Choose your handle')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SpacingTokens.space20),
          children: [
            Text(
              'Your handle is how people find you and mention you. '
              'Pick one you will keep: it cannot be changed yet.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: SpacingTokens.space24),
            TextField(
              key: const ValueKey('handle-field'),
              controller: _handle,
              autofocus: true,
              autocorrect: false,
              enableSuggestions: false,
              maxLength: 30,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                // Typed capitals become lowercase rather than being refused:
                // "Ada" is somebody's name, and "ada" is the handle for it.
                TextInputFormatter.withFunction(
                  (old, next) => next.copyWith(text: next.text.toLowerCase()),
                ),
                FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9_]')),
              ],
              onChanged: (_) => _scheduleCheck(),
              onSubmitted: (_) {
                if (free && !_saving) _choose();
              },
              decoration: const InputDecoration(
                labelText: 'Handle',
                prefixText: '@',
              ),
            ),
            Text(
              _status ?? '',
              key: const ValueKey('handle-status'),
              style: TextStyle(color: free ? scheme.primary : faint),
            ),
            if (_error != null) ...[
              const SizedBox(height: SpacingTokens.space8),
              Text(_error!, style: TextStyle(color: scheme.error)),
            ],
            const SizedBox(height: SpacingTokens.space32),
            AppButton(
              label: 'Continue',
              isLoading: _saving,
              enabled: free && !_checking && !_saving,
              onTap: _choose,
            ),
            const SizedBox(height: SpacingTokens.space16),
            Center(
              child: TextButton(
                onPressed: _saving
                    ? null
                    : () => ref.read(authNotifierProvider.notifier).logout(),
                child: const Text('Sign out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
