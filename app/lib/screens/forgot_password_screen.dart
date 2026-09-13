// lib/screens/forgot_password_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;

import '../providers/auth_provider.dart';
import '../services/platform_support.dart';
import '../utils/validators.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';

/// Asking for a password reset, and being told what to expect.
///
/// What was here before was a shell: one field, a Submit button, and a
/// `// Your reset logic here` where the reset should have been. Typing an
/// address and tapping Submit did nothing at all, silently, for ever -- and
/// [AuthRepository.sendPasswordReset] had been sitting finished behind it the
/// whole time, wired to nothing.
///
/// The instructions are the other half of the fix. A reset is the one flow
/// where the app goes quiet and the next thing that has to happen happens in
/// a different application entirely, minutes later. Everything somebody needs
/// in order to not give up -- which inbox, why it might be in spam, how long
/// the link lasts, what to do if it never comes -- is on the screen after
/// sending, because by then it is too late to ask.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _sending = false;

  /// The address the last mail went to, or null before one has. Held rather
  /// than read back off the controller so the confirmation names the address
  /// that was actually sent to, not whatever is in the box now.
  String? _sentTo;

  /// What went wrong, shown under the field rather than in a snackbar that
  /// slides away while somebody is still reading it.
  String? _failure;

  /// Seconds until another mail may be asked for.
  ///
  /// Supabase rate-limits these itself and answers a second request with an
  /// error rather than a mail, so a Resend button with no cooldown is a
  /// button that mostly fails. Counting down says why.
  int _cooldown = 0;
  Timer? _tick;

  @override
  void dispose() {
    _tick?.cancel();
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_sending || _cooldown > 0) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final address = _email.text.trim();
    setState(() {
      _sending = true;
      _failure = null;
    });

    try {
      await ref.read(authRepositoryProvider).sendPasswordReset(address);
      if (!mounted) return;
      setState(() {
        _sentTo = address;
        _sending = false;
      });
      _startCooldown();
    } on AuthException catch (error) {
      // Supabase's own words. They are written for a reader -- "For security
      // purposes, you can only request this after 41 seconds" -- and are more
      // use than anything this screen could invent in their place.
      if (!mounted) return;
      setState(() {
        _failure = error.message;
        _sending = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _failure = 'Could not reach Kyron to send that. $error';
        _sending = false;
      });
    }
  }

  void _startCooldown() {
    _tick?.cancel();
    setState(() => _cooldown = _cooldownSeconds);
    _tick = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return timer.cancel();
      setState(() => _cooldown--);
      if (_cooldown <= 0) timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset your password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SpacingTokens.space20),
          child: _sentTo == null ? _ask() : _sent(_sentTo!),
        ),
      ),
    );
  }

  /// Before sending: what is about to happen, and the one thing needed for it.
  Widget _ask() {
    final scheme = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Type the address you signed up with. Kyron will mail you a link '
            'that opens the app and lets you set a new password.',
            style: TextStyle(
              fontSize: TypographyTokens.fontSize3,
              height: 1.5,
              color: scheme.onSurface.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: SpacingTokens.space20),
          AppInputField(
            label: 'Email',
            hint: 'you@example.com',
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            validator: Validators.email,
          ),
          if (_failure != null) ...[
            const SizedBox(height: SpacingTokens.space12),
            _Notice(
              icon: Iconsax.info_circle,
              tone: KyronTheme.errorPink,
              text: _failure!,
            ),
          ],
          const SizedBox(height: SpacingTokens.space20),
          AppButton(
            label: 'Send the link',
            onTap: _send,
            isLoading: _sending,
          ),
          const SizedBox(height: SpacingTokens.space24),
          const _Aside(
            icon: Iconsax.info_circle,
            text: 'Signed up with Google? You have never had a Kyron password '
                '— but you can set one here, using the same address as your '
                'Google account. Both ways in will work afterwards.',
          ),
        ],
      ),
    );
  }

  /// After sending: everything needed to finish somewhere else.
  ///
  /// Careful about what it claims. Supabase answers the same way whether or
  /// not an account exists, deliberately, so that this screen cannot be used
  /// to find out who has one -- which means "we sent it" would be a
  /// statement the app cannot actually make.
  Widget _sent(String address) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: KyronTheme.successAqua.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(RadiusTokens.radiusLg),
          ),
          child: const Icon(Iconsax.sms_tracking,
              size: 26, color: KyronTheme.successAqua),
        ),
        const SizedBox(height: SpacingTokens.space16),
        Text(
          'Check $address',
          style: TextStyle(
            fontSize: TypographyTokens.fontSize6,
            fontWeight: FontWeight.w700,
            color: scheme.onSurface,
          ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          'If there is a Kyron account on that address, a reset link is on '
          'its way to it now.',
          style: TextStyle(
            fontSize: TypographyTokens.fontSize3,
            height: 1.5,
            color: scheme.onSurface.withValues(alpha: 0.72),
          ),
        ),
        const SizedBox(height: SpacingTokens.space24),
        const _Step(
          number: '1',
          title: 'Open the mail from Kyron',
          detail: 'It arrives within a minute or so. If it is not there, look '
              'in spam or promotions — a first message from a new sender '
              'often lands in one of them.',
        ),
        _Step(
          number: '2',
          title: 'Tap the link inside it',
          detail: PlatformSupport.current.authRedirect
              ? 'It opens Kyron straight at the screen where you set the new '
                  'password. It is good for one hour and one use, so tap it '
                  'on the device you want to stay signed in on.'
              : 'The link opens Kyron on the phone, not on '
                  '${PlatformSupport.current.name} — so open the mail on your '
                  'phone with Kyron installed. It is good for one hour and '
                  'one use.',
        ),
        const _Step(
          number: '3',
          title: 'Set a password and carry on',
          detail: 'You stay signed in on that device. Nothing else about your '
              'account changes, and anyone who had the old password no longer '
              'has anything.',
          last: true,
        ),
        const SizedBox(height: SpacingTokens.space8),
        AppButton(
          label: _cooldown > 0 ? 'Send again in ${_cooldown}s' : 'Send again',
          onTap: _send,
          isOutlined: true,
          isLoading: _sending,
          enabled: _cooldown == 0,
        ),
        if (_failure != null) ...[
          const SizedBox(height: SpacingTokens.space12),
          _Notice(
            icon: Iconsax.info_circle,
            tone: KyronTheme.errorPink,
            text: _failure!,
          ),
        ],
        const SizedBox(height: SpacingTokens.space12),
        TextButton(
          onPressed: () => setState(() {
            _sentTo = null;
            _failure = null;
          }),
          child: const Text('Use a different address'),
        ),
        const SizedBox(height: SpacingTokens.space16),
        const _Aside(
          icon: Iconsax.support,
          text: 'Nothing after ten minutes and nothing in spam usually means '
              'the account is on a different address. Try the other one — '
              'there is no limit on how many you check.',
        ),
      ],
    );
  }

  /// Long enough that Supabase's own limiter is not the thing saying no.
  static const int _cooldownSeconds = 60;
}

/// One numbered thing to do, with the rail running down to the next.
class _Step extends StatelessWidget {
  final String number;
  final String title;
  final String detail;
  final bool last;

  const _Step({
    required this.number,
    required this.title,
    required this.detail,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    fontSize: TypographyTokens.fontSize1,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    color: scheme.primary.withValues(alpha: 0.12),
                  ),
                ),
            ],
          ),
          const SizedBox(width: SpacingTokens.space12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: last ? SpacingTokens.space16 : SpacingTokens.space20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize3,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    detail,
                    style: TextStyle(
                      fontSize: TypographyTokens.fontSize2,
                      height: 1.5,
                      color: scheme.onSurface.withValues(alpha: 0.68),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Something worth knowing that is not a step and not an error.
class _Aside extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Aside({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        color: dark ? KyronTheme.darkPillBg : KyronTheme.lightPillBg,
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: scheme.onSurface.withValues(alpha: 0.5)),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                height: 1.55,
                color: scheme.onSurface.withValues(alpha: 0.68),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A failure, said in place and left there.
class _Notice extends StatelessWidget {
  final IconData icon;
  final Color tone;
  final String text;

  const _Notice({required this.icon, required this.tone, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacingTokens.space12),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: tone),
          const SizedBox(width: SpacingTokens.space8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize2,
                height: 1.5,
                color: tone,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
