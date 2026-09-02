// lib/widgets/create_post/poll_editor.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../../models/composer_poll.dart';
import '../../providers/composer_provider.dart';

/// The poll being written, under the composer's text field.
///
/// Inline rather than a separate screen. The question and the answers are one
/// thought, and sending someone to another screen to write the answers means
/// they cannot see the question they are writing them for.
class PollEditor extends ConsumerStatefulWidget {
  const PollEditor({super.key});

  @override
  ConsumerState<PollEditor> createState() => _PollEditorState();
}

class _PollEditorState extends ConsumerState<PollEditor> {
  /// One controller per answer, kept across rebuilds.
  ///
  /// Rebuilding these from state on every keystroke would reset the cursor to
  /// the end of the box, so typing into the middle of an answer would be
  /// impossible.
  final List<TextEditingController> _controllers = [];

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _sync(ComposerPoll poll) {
    while (_controllers.length < poll.options.length) {
      _controllers.add(TextEditingController(
        text: poll.options[_controllers.length],
      ));
    }
    while (_controllers.length > poll.options.length) {
      _controllers.removeLast().dispose();
    }
    // Only when they actually differ -- assigning `text` moves the cursor.
    for (var i = 0; i < poll.options.length; i++) {
      if (_controllers[i].text != poll.options[i]) {
        _controllers[i].text = poll.options[i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final poll = ref.watch(composerProvider.select((s) => s.poll));
    if (poll == null) return const SizedBox.shrink();

    _sync(poll);

    final scheme = Theme.of(context).colorScheme;
    final notifier = ref.read(composerProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(top: SpacingTokens.space12),
      child: Container(
        padding: const EdgeInsets.all(SpacingTokens.space12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Iconsax.chart_2_copy, size: 16, color: scheme.primary),
                const SizedBox(width: SpacingTokens.space8),
                Text(
                  'Poll',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: scheme.primary,
                  ),
                ),
                const Spacer(),
                _Tap(
                  tooltip: 'Remove this poll',
                  onTap: notifier.togglePoll,
                  child: Icon(
                    Iconsax.trash_copy,
                    size: 16,
                    color: scheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SpacingTokens.space8),

            for (var i = 0; i < poll.options.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controllers[i],
                        maxLength: ComposerPoll.maxOptionLength,
                        // Hard-stopped rather than only counted: an answer the
                        // server would reject should not be typeable.
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                            ComposerPoll.maxOptionLength,
                          ),
                        ],
                        onChanged: (value) =>
                            notifier.setPoll(poll.withOption(i, value)),
                        decoration: InputDecoration(
                          hintText: 'Answer ${i + 1}',
                          counterText: '',
                          isDense: true,
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    if (poll.canRemoveOption) ...[
                      const SizedBox(width: SpacingTokens.space4),
                      _Tap(
                        tooltip: 'Remove this answer',
                        onTap: () => notifier.setPoll(poll.removeOption(i)),
                        child: Icon(
                          Iconsax.minus_cirlce_copy,
                          size: 18,
                          color: scheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

            if (poll.canAddOption)
              TextButton.icon(
                onPressed: () => notifier.setPoll(poll.addOption()),
                icon: const Icon(Iconsax.add, size: 16),
                label: const Text('Add an answer'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingTokens.space8,
                  ),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(fontSize: 13),
                ),
              ),

            Divider(
              height: SpacingTokens.space16,
              thickness: 0.5,
              color: scheme.outline.withValues(alpha: 0.2),
            ),

            Row(
              children: [
                Icon(
                  Iconsax.clock_copy,
                  size: 15,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
                const SizedBox(width: SpacingTokens.space8),
                Text(
                  'Open for',
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const Spacer(),
                DropdownButton<int>(
                  value: poll.durationMinutes,
                  isDense: true,
                  underline: const SizedBox.shrink(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                  items: [
                    for (final minutes in ComposerPoll.durations)
                      DropdownMenuItem(
                        value: minutes,
                        child: Text(
                          ComposerPoll(
                                  options: const [], durationMinutes: minutes)
                              .durationLabel,
                        ),
                      ),
                  ],
                  onChanged: (value) => value == null
                      ? null
                      : notifier.setPoll(
                          poll.copyWith(durationMinutes: value),
                        ),
                ),
              ],
            ),

            // Said while it is still fixable, rather than as a rejection after
            // Post is pressed.
            if (poll.problem != null)
              Padding(
                padding: const EdgeInsets.only(top: SpacingTokens.space4),
                child: Text(
                  poll.problem!,
                  style: TextStyle(fontSize: 12, color: scheme.error),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Tap extends StatelessWidget {
  final String tooltip;
  final VoidCallback onTap;
  final Widget child;

  const _Tap({
    required this.tooltip,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(width: 30, height: 30, child: Center(child: child)),
        ),
      ),
    );
  }
}
