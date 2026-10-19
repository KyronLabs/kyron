// lib/screens/verification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/verification.dart';
import '../providers/current_user_provider.dart';
import '../providers/verification_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/action_button.dart';
import '../widgets/empty_state.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/stamp.dart';
import '../widgets/toast.dart';
import '../widgets/verified_badge.dart';
import 'account_status_screen.dart' show Quote, standingDay;

/// Asking for the verified badge.
///
/// The badge says one thing: somebody on the Kyron team checked this account
/// is who it says it is. It gives no extra reach and is not for sale, and
/// the evidence is links the reviewer can follow, never identity documents.
///
/// The page leads with heavy type and a switch set into the sentence, then
/// a strip of three stamps -- ask, a person checks, the badge -- cut from one
/// painted landscape. Below that, whatever applies now: the badge, the
/// request waiting, the answer, or what is still needed and the form.
class VerificationScreen extends ConsumerWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationStatusProvider);
    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Verification'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(verificationStatusProvider),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space20,
              SpacingTokens.space8,
              SpacingTokens.space20,
              SpacingTokens.space40,
            ),
            children: [
              const _Hero(),
              const SizedBox(height: SpacingTokens.space16),
              Text(
                'The badge says somebody on the Kyron team checked this '
                'account is who it says it is. It gives no extra reach, and '
                'it is not for sale.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: SpacingTokens.space24),
              const StampStrip(
                panels: [
                  (
                    title: 'Ask',
                    detail: 'Who you are, and a link\nthat proves it',
                  ),
                  (
                    title: 'A person\nchecks',
                    detail: 'Somebody on the team\nfollows your links',
                  ),
                  (
                    title: 'The badge',
                    detail: 'Beside your name,\neverywhere it shows',
                  ),
                ],
              ),
              const SizedBox(height: SpacingTokens.space32),
              state.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(SpacingTokens.space24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => EmptyState(
                  art: EmptyArt.offline,
                  title: 'Could not load where you stand',
                  detail: describeApiError(error, sessionIsLive: true),
                  action: 'Try again',
                  onAction: () => ref.invalidate(verificationStatusProvider),
                ),
                data: (state) => _Now(state: state),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Get [switch] verified [stamp] on Kyron." -- large, heavy, and with the
/// pieces set into the line the way the words are.
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final ink = Theme.of(context).colorScheme.onSurface;
    return LayoutBuilder(
      builder: (context, box) {
        final size = (box.maxWidth / 5.2).clamp(40.0, 76.0);
        final type = TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w700,
          height: 1.0,
          letterSpacing: -size * 0.05,
          color: ink,
        );
        final pillHeight = size * 0.66;

        Widget line(List<Widget> parts) => FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: parts,
              ),
            );

        return Semantics(
          header: true,
          label: 'Get verified on Kyron',
          excludeSemantics: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              line([
                Text('Get', style: type),
                SizedBox(width: size * 0.2),
                _Switch(height: pillHeight, ink: ink),
              ]),
              line([Text('verified', style: type)]),
              line([
                _StampPill(height: pillHeight),
                SizedBox(width: size * 0.2),
                Text('on Kyron.', style: type),
              ]),
            ],
          ),
        );
      },
    );
  }
}

/// A switch, on: the badge is the knob.
class _Switch extends StatelessWidget {
  final double height;
  final Color ink;

  const _Switch({required this.height, required this.ink});

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return Container(
      width: height * 2.1,
      height: height,
      padding: EdgeInsets.all(height * 0.1),
      decoration: BoxDecoration(
        color: ink,
        borderRadius: BorderRadius.circular(height),
      ),
      alignment: Alignment.centerRight,
      child: VerifiedBadge(size: height * 0.8, color: surface, tick: ink),
    );
  }
}

/// A pill with the landscape in it: the stamp the badge comes from.
class _StampPill extends StatelessWidget {
  final double height;
  const _StampPill({required this.height});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(height),
        child: SizedBox(
          width: height * 1.8,
          height: height,
          child: const CustomPaint(painter: StampLandscape()),
        ),
      );
}

/// Whatever applies now.
class _Now extends StatelessWidget {
  final VerificationState state;
  const _Now({required this.state});

  @override
  Widget build(BuildContext context) {
    final request = state.request;
    if (state.verified) return _Verified(since: state.verifiedAt);
    if (state.pending && request != null) return _Waiting(request: request);
    if (request?.status == VerificationRequestStatus.denied &&
        !state.canApply &&
        state.nextApplyAt != null) {
      return _NotYet(request: request!, again: state.nextApplyAt!);
    }
    return _Ask(state: state);
  }
}

class _Verified extends StatelessWidget {
  final DateTime? since;
  const _Verified({this.since});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const VerifiedBadge(size: 36),
            const SizedBox(width: SpacingTokens.space12),
            Expanded(
              child: Text(
                "You're verified",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space12),
        Text(
          [
            if (since != null) 'Since ${standingDay(since!)}.',
            'The badge stays while your name does. Change your name and it '
                'comes off until somebody checks the new one.',
          ].join(' '),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _Waiting extends ConsumerStatefulWidget {
  final VerificationRequestView request;
  const _Waiting({required this.request});

  @override
  ConsumerState<_Waiting> createState() => _WaitingState();
}

class _WaitingState extends ConsumerState<_Waiting> {
  bool _withdrawing = false;

  Future<void> _withdraw() async {
    setState(() => _withdrawing = true);
    try {
      await ref.read(verificationRepositoryProvider).withdraw();
      ref.invalidate(verificationStatusProvider);
      if (mounted) Toast.show(context, 'Request withdrawn.');
    } catch (error) {
      if (!mounted) return;
      setState(() => _withdrawing = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.request;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Request ${request.number} is with a person',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        Text(
          'Sent ${standingDay(request.createdAt)}, as '
          '${request.category.label.toLowerCase()}. You will get a '
          'notification when it is decided.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: SpacingTokens.space16),
        ActionButton(
          label: 'Withdraw the request',
          kind: ActionButtonKind.outlined,
          busy: _withdrawing,
          onPressed: _withdraw,
        ),
      ],
    );
  }
}

class _NotYet extends StatelessWidget {
  final VerificationRequestView request;
  final DateTime again;
  const _NotYet({required this.request, required this.again});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request ${request.number} was not approved',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        if (request.response != null) ...[
          const SizedBox(height: SpacingTokens.space8),
          Quote(request.response!),
        ],
        const SizedBox(height: SpacingTokens.space12),
        Text(
          'You can ask again from ${standingDay(again)}.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

/// What is still needed, and the form.
class _Ask extends ConsumerStatefulWidget {
  final VerificationState state;
  const _Ask({required this.state});

  @override
  ConsumerState<_Ask> createState() => _AskState();
}

class _AskState extends ConsumerState<_Ask> {
  VerificationCategory _category = VerificationCategory.creator;
  final _about = TextEditingController();
  final _links = [TextEditingController()];
  bool _sending = false;
  String? _error;

  static const minAbout = 30;

  @override
  void dispose() {
    _about.dispose();
    for (final link in _links) {
      link.dispose();
    }
    super.dispose();
  }

  List<String> get _validLinks => [
        for (final link in _links)
          if (RegExp(r'^https?://\S+\.\S+').hasMatch(link.text.trim()))
            link.text.trim(),
      ];

  bool get _canSend =>
      !_sending &&
      widget.state.eligible &&
      _about.text.trim().length >= minAbout &&
      _validLinks.isNotEmpty;

  Future<void> _send() async {
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref.read(verificationRepositoryProvider).apply(
            category: _category,
            about: _about.text.trim(),
            links: _validLinks,
          );
      ref.invalidate(verificationStatusProvider);
      if (mounted) {
        Toast.show(context, 'Sent. A person will look at it.');
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = describeApiError(error, sessionIsLive: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final faint = scheme.onSurface.withValues(alpha: .55);
    final missing = widget.state.requirements.where((r) => !r.met).toList();
    final profileFixes = missing.any(
      (r) => const {'photo', 'name', 'bio'}.contains(r.key),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Before you ask',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        for (final r in widget.state.requirements)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Icon(
                  r.met ? Iconsax.tick_circle : Iconsax.record_copy,
                  size: 20,
                  color: r.met ? scheme.primary : faint,
                ),
                const SizedBox(width: SpacingTokens.space12),
                Expanded(
                  child: Text(
                    r.label,
                    style: TextStyle(color: r.met ? null : faint),
                  ),
                ),
              ],
            ),
          ),
        if (profileFixes)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.editProfile);
                ref.invalidate(verificationStatusProvider);
                ref.read(currentUserProvider.notifier).refresh();
              },
              icon: const Icon(Iconsax.edit_2_copy, size: 18),
              label: const Text('Edit your profile'),
            ),
          ),
        const SizedBox(height: SpacingTokens.space24),
        Text(
          'Ask',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: SpacingTokens.space12),
        Wrap(
          spacing: SpacingTokens.space8,
          runSpacing: SpacingTokens.space8,
          children: [
            for (final category in VerificationCategory.values)
              ChoiceChip(
                label: Text(category.label),
                selected: _category == category,
                onSelected: (_) => setState(() => _category = category),
              ),
          ],
        ),
        const SizedBox(height: SpacingTokens.space16),
        TextField(
          controller: _about,
          maxLines: 5,
          maxLength: 1000,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Who you are',
            alignLabelWithHint: true,
            hintText: 'I write about birds here and on my own site.',
            helperText: 'In your own words, what the reviewer should know.',
          ),
        ),
        const SizedBox(height: SpacingTokens.space8),
        for (var i = 0; i < _links.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
            child: TextField(
              controller: _links[i],
              keyboardType: TextInputType.url,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: i == 0 ? 'Where we can check' : 'Another link',
                hintText: 'https://',
                prefixIcon: const Icon(Iconsax.link_21_copy, size: 18),
              ),
            ),
          ),
        if (_links.length < 3)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () =>
                  setState(() => _links.add(TextEditingController())),
              icon: const Icon(Iconsax.add_copy, size: 18),
              label: const Text('Add another link'),
            ),
          ),
        Text(
          'A site or another profile that says this Kyron account is yours: '
          'put your Kyron name, or a link to your profile, on it. Kyron never '
          'asks for ID documents.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (_error != null) ...[
          const SizedBox(height: SpacingTokens.space12),
          Text(
            _error!,
            style: TextStyle(
              color: scheme.error,
              fontSize: TypographyTokens.fontSize2,
            ),
          ),
        ],
        const SizedBox(height: SpacingTokens.space16),
        ActionButton(
          label: 'Ask to be verified',
          icon: Iconsax.send_2_copy,
          expand: true,
          busy: _sending,
          onPressed: _canSend ? _send : null,
        ),
        if (!widget.state.eligible) ...[
          const SizedBox(height: SpacingTokens.space8),
          Text(
            'Everything above needs a tick before you can ask.',
            style: TextStyle(color: faint),
          ),
        ],
      ],
    );
  }
}
