// lib/screens/report_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../providers/moderation_provider.dart';
import '../repositories/moderation_repository.dart';
import '../services/app_log.dart';
import '../utils/api_error_message.dart';

/// Reporting a post, a comment or an account.
///
/// Two steps on purpose. Picking a reason from a list of twelve and writing an
/// explanation on the same screen makes both feel optional; separating them
/// means the reason is always chosen deliberately, and the confirmation says
/// what actually happens next rather than thanking the reporter and closing.
class ReportScreen extends ConsumerStatefulWidget {
  final ReportTarget target;
  final String targetId;

  /// What is being reported, in words: "this post", "@ada".
  final String subject;

  const ReportScreen({
    super.key,
    required this.target,
    required this.targetId,
    required this.subject,
  });

  static Future<void> open(
    BuildContext context, {
    required ReportTarget target,
    required String targetId,
    required String subject,
  }) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => ReportScreen(
          target: target,
          targetId: targetId,
          subject: subject,
        ),
      ),
    );
  }

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  final _detail = TextEditingController();

  ReportReason? _reason;
  bool _sending = false;
  bool _sent = false;
  String? _error;

  @override
  void dispose() {
    _detail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(_sent ? 'Report sent' : 'Report'),
      ),
      body: SafeArea(
        child: _sent
            ? _Sent(subject: widget.subject)
            : _reason == null
                ? _reasons()
                : _details(_reason!),
      ),
    );
  }

  Widget _reasons() {
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.only(bottom: SpacingTokens.space32),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingTokens.space20,
            SpacingTokens.space16,
            SpacingTokens.space20,
            SpacingTokens.space8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is wrong with ${widget.subject}?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: SpacingTokens.space4),
              Text(
                'Your report is not shared with them. We keep a copy of what '
                'you reported, so it can still be reviewed if it is deleted.',
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurface.withValues(alpha: .7),
                ),
              ),
            ],
          ),
        ),
        for (final reason in ReportReason.values)
          ListTile(
            title: Text(reason.label),
            subtitle: Text(reason.detail),
            trailing: const Icon(Iconsax.arrow_right_3_copy, size: 16),
            onTap: () => setState(() => _reason = reason),
          ),
      ],
    );
  }

  Widget _details(ReportReason reason) {
    final scheme = Theme.of(context).colorScheme;
    // "Something else" tells a reviewer nothing on its own.
    final required = reason.needsDetail;
    final canSend = !_sending && (!required || _detail.text.trim().length >= 5);

    return ListView(
      padding: const EdgeInsets.all(SpacingTokens.space20),
      children: [
        Container(
          padding: const EdgeInsets.all(SpacingTokens.space16),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reason.label,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: SpacingTokens.space2),
                    Text(
                      reason.detail,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurface.withValues(alpha: .7),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed:
                    _sending ? null : () => setState(() => _reason = null),
                child: const Text('Change'),
              ),
            ],
          ),
        ),
        const SizedBox(height: SpacingTokens.space20),
        Text(
          required ? 'Tell us what is wrong' : 'Anything to add? (optional)',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: SpacingTokens.space8),
        TextField(
          controller: _detail,
          maxLines: 5,
          maxLength: 1000,
          enabled: !_sending,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'What happened, and what should we look at?',
            border: OutlineInputBorder(),
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: SpacingTokens.space8),
          Text(_error!, style: TextStyle(color: scheme.error, fontSize: 13)),
        ],
        const SizedBox(height: SpacingTokens.space8),
        FilledButton(
          onPressed: canSend ? _send : null,
          child: _sending
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Send report'),
        ),
        const SizedBox(height: SpacingTokens.space12),
        Text(
          'Reporting the same thing twice does not add weight to it -- we keep '
          'one report per person.',
          style: TextStyle(
            fontSize: 12,
            color: scheme.onSurface.withValues(alpha: .6),
          ),
        ),
      ],
    );
  }

  Future<void> _send() async {
    setState(() {
      _sending = true;
      _error = null;
    });

    try {
      await ref.read(moderationRepositoryProvider).report(
            target: widget.target,
            targetId: widget.targetId,
            reason: _reason!,
            detail: _detail.text,
          );
      AppLog.instance.info(
        'moderation',
        'Reported ${widget.target.wire} ${widget.targetId} (${_reason!.wire})',
      );
      if (!mounted) return;
      setState(() {
        _sending = false;
        _sent = true;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = describeApiError(e, sessionIsLive: true);
      });
    }
  }
}

class _Sent extends StatelessWidget {
  final String subject;

  const _Sent({required this.subject});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.tick_circle_copy, size: 48, color: scheme.primary),
            const SizedBox(height: SpacingTokens.space16),
            Text(
              'Thanks for telling us',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              'Your report about $subject has been received and is queued for '
              'review. We do not tell them who reported it.',
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: .7)),
            ),
            const SizedBox(height: SpacingTokens.space20),
            Text(
              'If you also want to stop seeing them, mute or block them from '
              'the same menu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurface.withValues(alpha: .55),
              ),
            ),
            const SizedBox(height: SpacingTokens.space24),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
