// lib/screens/community_poll_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../widgets/action_button.dart';
import '../widgets/kyron_app_bar.dart';

/// A poll as it is about to be asked: the question, its answers, and whether
/// people may choose more than one.
typedef PollDraft = ({String question, List<String> options, bool multiple});

/// Writing a poll for a community chat. Answers the poll, or null when the
/// reader backed out. The server holds the same rules -- two to ten answers,
/// each once -- whatever this screen lets through.
class CommunityPollScreen extends StatefulWidget {
  const CommunityPollScreen({super.key});

  static const minOptions = 2;
  static const maxOptions = 10;
  static const maxOption = 100;

  static Future<PollDraft?> open(BuildContext context) =>
      Navigator.of(context).push<PollDraft>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const CommunityPollScreen(),
        ),
      );

  @override
  State<CommunityPollScreen> createState() => _CommunityPollScreenState();
}

class _CommunityPollScreenState extends State<CommunityPollScreen> {
  final _question = TextEditingController();
  final List<TextEditingController> _options = [
    TextEditingController(),
    TextEditingController(),
  ];
  bool _multiple = false;

  @override
  void initState() {
    super.initState();
    _question.addListener(_changed);
    for (final o in _options) {
      o.addListener(_changed);
    }
  }

  void _changed() => setState(() {});

  @override
  void dispose() {
    _question.dispose();
    for (final o in _options) {
      o.dispose();
    }
    super.dispose();
  }

  List<String> get _answers => [
        for (final o in _options)
          if (o.text.trim().isNotEmpty)
            o.text.trim().replaceAll(RegExp(r'\s+'), ' '),
      ];

  /// Two answers or more, none twice.
  bool get _ready {
    final answers = _answers;
    return _question.text.trim().isNotEmpty &&
        answers.length >= CommunityPollScreen.minOptions &&
        answers.map((a) => a.toLowerCase()).toSet().length == answers.length;
  }

  void _add() {
    if (_options.length >= CommunityPollScreen.maxOptions) return;
    setState(
        () => _options.add(TextEditingController()..addListener(_changed)));
  }

  void _remove(int index) {
    if (_options.length <= CommunityPollScreen.minOptions) return;
    setState(() => _options.removeAt(index).dispose());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final answers = _answers;
    final repeated =
        answers.map((a) => a.toLowerCase()).toSet().length != answers.length;
    return Scaffold(
      appBar: KyronAppBar(
        title: Text(l10n.ui('ui_cchat_poll_new', 'New poll')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(SpacingTokens.space16),
        children: [
          TextField(
            key: const ValueKey('poll-question'),
            controller: _question,
            autofocus: true,
            maxLength: 2000,
            minLines: 1,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.ui('ui_cchat_poll_question', 'Question'),
              counterText: '',
            ),
          ),
          const SizedBox(height: SpacingTokens.space12),
          for (final (i, option) in _options.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingTokens.space8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: ValueKey('poll-option-$i'),
                      controller: option,
                      maxLength: CommunityPollScreen.maxOption,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: l10n
                            .ui('ui_cchat_poll_option', r'Answer $n')
                            .replaceAll(r'$n', '${i + 1}'),
                        counterText: '',
                      ),
                    ),
                  ),
                  if (_options.length > CommunityPollScreen.minOptions)
                    IconButton(
                      tooltip: l10n.remove,
                      icon: const Icon(Iconsax.minus_cirlce_copy, size: 20),
                      onPressed: () => _remove(i),
                    ),
                ],
              ),
            ),
          if (_options.length < CommunityPollScreen.maxOptions)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                key: const ValueKey('poll-add-option'),
                onPressed: _add,
                icon: const Icon(Iconsax.add_copy, size: 18),
                label: Text(l10n.ui('ui_cchat_poll_add', 'Add an answer')),
              ),
            ),
          if (repeated)
            Text(
              l10n.ui(
                'ui_cchat_poll_repeated',
                'Each answer can be in a poll once.',
              ),
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                color: scheme.error,
              ),
            ),
          SwitchListTile.adaptive(
            key: const ValueKey('poll-multiple'),
            contentPadding: EdgeInsets.zero,
            value: _multiple,
            onChanged: (on) => setState(() => _multiple = on),
            title: Text(
              l10n.ui('ui_cchat_poll_multiple', 'Let people choose several'),
            ),
          ),
          Text(
            l10n.ui(
              'ui_cchat_poll_detail',
              'Everyone sees how many chose each answer, never who.',
            ),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          ActionButton(
            key: const ValueKey('poll-send'),
            label: l10n.send,
            icon: Iconsax.send_1,
            expand: true,
            onPressed: _ready
                ? () => Navigator.pop(context, (
                      question: _question.text.trim(),
                      options: _answers,
                      multiple: _multiple,
                    ))
                : null,
          ),
        ],
      ),
    );
  }
}
