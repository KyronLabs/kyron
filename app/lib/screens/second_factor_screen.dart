// lib/screens/second_factor_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import 'package:supabase_flutter/supabase_flutter.dart' show Factor;

import '../l10n/app_localizations.dart';
import '../services/second_factor.dart';
import '../widgets/action_button.dart';
import '../widgets/settings_scaffold.dart';
import '../widgets/toast.dart';

/// Two-step sign-in, from Settings. Staff only: the row that opens this is
/// shown to nobody else.
class SecondFactorScreen extends StatefulWidget {
  const SecondFactorScreen({super.key, this.service});

  /// Replaceable in tests; the app uses Supabase.
  final SecondFactor? service;

  @override
  State<SecondFactorScreen> createState() => _SecondFactorScreenState();
}

class _SecondFactorScreenState extends State<SecondFactorScreen> {
  late final SecondFactor _service = widget.service ?? SecondFactor();
  final _code = TextEditingController();

  bool _loading = true;
  bool _busy = false;
  String? _enrolledId;
  ({String factorId, String qrSvg, String secret})? _setup;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final factor = await _service.verifiedFactor();
      if (mounted) setState(() => _enrolledId = factor?.id);
    } catch (_) {
      // Shown as not set up; setting up will say what went wrong.
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _start() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final setup = await _service.start();
      if (mounted) setState(() => _setup = setup);
    } catch (_) {
      if (mounted) {
        setState(() => _error =
            l10n.ui('ui_2fa_failed', "Couldn't start setup. Try again."));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirm() async {
    final setup = _setup;
    if (setup == null || _busy) return;
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await _service.verify(setup.factorId, _code.text);
      if (!mounted) return;
      setState(() {
        _enrolledId = setup.factorId;
        _setup = null;
        _code.clear();
      });
    } catch (_) {
      if (mounted) setState(() => _error = _wrongCode(l10n));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove() async {
    final id = _enrolledId;
    if (id == null || _busy) return;
    // Removing it asks for a session that has passed it: a stolen password
    // must not be enough to take the second factor off.
    if (!await passStaffSecondFactor(context, service: _service)) return;
    setState(() => _busy = true);
    try {
      await _service.remove(id);
      if (mounted) setState(() => _enrolledId = null);
    } catch (_) {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context)
            .ui('ui_2fa_failed', "Couldn't start setup. Try again."));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final setup = _setup;

    return SettingsScaffold(
      title: l10n.ui('ui_2fa_title', 'Two-step sign-in'),
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.ui(
                    'ui_2fa_intro',
                    'Staff tools ask for a code from an authenticator app as '
                        'well as your sign-in, so a stolen password alone '
                        'cannot use them.',
                  ),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: SpacingTokens.space24),
                if (_enrolledId != null) ...[
                  Text(
                    l10n.ui('ui_2fa_on', 'Two-step sign-in is on.'),
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: SpacingTokens.space16),
                  ActionButton(
                    key: const ValueKey('2fa-remove'),
                    label: l10n.ui('ui_2fa_remove', 'Remove'),
                    kind: ActionButtonKind.outlined,
                    destructive: true,
                    busy: _busy,
                    expand: true,
                    onPressed: _remove,
                  ),
                ] else if (setup == null)
                  ActionButton(
                    key: const ValueKey('2fa-start'),
                    label: l10n.ui('ui_2fa_set_up', 'Set up'),
                    busy: _busy,
                    expand: true,
                    onPressed: _start,
                  )
                else ...[
                  Text(
                    l10n.ui(
                      'ui_2fa_scan',
                      'Scan this with your authenticator app, or enter the '
                          'key below. Add it to two apps if you can: losing '
                          'your only one means asking support to remove it.',
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space16),
                  Center(
                    child: Container(
                      // Always light: a QR code on a dark page will not scan.
                      color: Colors.white,
                      padding: const EdgeInsets.all(SpacingTokens.space12),
                      child: SvgPicture.string(
                        setup.qrSvg,
                        width: 192,
                        height: 192,
                      ),
                    ),
                  ),
                  const SizedBox(height: SpacingTokens.space16),
                  Text(
                    l10n.ui('ui_2fa_key', 'Setup key'),
                    style: theme.textTheme.labelMedium,
                  ),
                  Row(
                    children: [
                      Expanded(child: SelectableText(setup.secret)),
                      IconButton(
                        icon: const Icon(Iconsax.copy_copy, size: 20),
                        tooltip: l10n.ui('ui_2fa_copied', 'Setup key copied'),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: setup.secret),
                          );
                          if (!context.mounted) return;
                          Toast.show(
                            context,
                            l10n.ui('ui_2fa_copied', 'Setup key copied'),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: SpacingTokens.space16),
                  _CodeField(controller: _code, onDone: _confirm),
                  const SizedBox(height: SpacingTokens.space16),
                  ActionButton(
                    key: const ValueKey('2fa-confirm'),
                    label: l10n.ui('ui_2fa_confirm', 'Confirm'),
                    busy: _busy,
                    expand: true,
                    onPressed: _confirm,
                  ),
                ],
                if (_error != null) ...[
                  const SizedBox(height: SpacingTokens.space12),
                  Text(
                    _error!,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ],
              ],
            ),
    );
  }
}

String _wrongCode(AppLocalizations l10n) => l10n.ui(
      'ui_2fa_wrong',
      "That code didn't work. Check the time on your phone and try again.",
    );

class _CodeField extends StatelessWidget {
  const _CodeField({required this.controller, required this.onDone});

  final TextEditingController controller;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const ValueKey('2fa-code'),
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.number,
      maxLength: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autofillHints: const [AutofillHints.oneTimeCode],
      onSubmitted: (_) => onDone(),
      decoration: InputDecoration(
        labelText:
            AppLocalizations.of(context).ui('ui_2fa_code', '6-digit code'),
        counterText: '',
      ),
    );
  }
}

/// Makes sure this session has passed the second factor before staff tools,
/// asking for the code when it has not. True to go on.
///
/// Nothing is asked when the session already passed, or when no
/// authenticator is enrolled yet: then the API decides, and while
/// STAFF_REQUIRE_SECOND_FACTOR is off it lets staff through as before.
Future<bool> passStaffSecondFactor(
  BuildContext context, {
  SecondFactor? service,
}) async {
  final secondFactor = service ?? SecondFactor();
  Factor? factor;
  try {
    if (secondFactor.sessionPassed) return true;
    factor = await secondFactor.verifiedFactor();
  } catch (_) {
    return true;
  }
  if (factor == null || !context.mounted) return true;
  final passed = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _CodeSheet(service: secondFactor, factorId: factor!.id),
  );
  return passed ?? false;
}

class _CodeSheet extends StatefulWidget {
  const _CodeSheet({required this.service, required this.factorId});

  final SecondFactor service;
  final String factorId;

  @override
  State<_CodeSheet> createState() => _CodeSheetState();
}

class _CodeSheetState extends State<_CodeSheet> {
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (_busy) return;
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await widget.service.verify(widget.factorId, _code.text);
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = _wrongCode(l10n);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SpacingTokens.space20,
          SpacingTokens.space20,
          SpacingTokens.space20,
          SpacingTokens.space20 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.ui(
                  'ui_2fa_enter', 'Enter the code from your authenticator app'),
              style: const TextStyle(
                fontSize: TypographyTokens.fontSize6,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SpacingTokens.space16),
            _CodeField(controller: _code, onDone: _verify),
            if (_error != null) ...[
              const SizedBox(height: SpacingTokens.space8),
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: SpacingTokens.space16),
            ActionButton(
              key: const ValueKey('2fa-verify'),
              label: l10n.ui('ui_2fa_verify', 'Verify'),
              busy: _busy,
              expand: true,
              onPressed: _verify,
            ),
          ],
        ),
      ),
    );
  }
}
