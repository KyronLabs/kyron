// lib/screens/drafts_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/composer_model.dart';
import '../providers/composer_provider.dart';
import '../services/draft_service.dart';
import '../widgets/empty_state.dart';

/// Everything written and not sent.
class DraftsScreen extends ConsumerStatefulWidget {
  const DraftsScreen({super.key});

  @override
  ConsumerState<DraftsScreen> createState() => _DraftsScreenState();
}

class _DraftsScreenState extends ConsumerState<DraftsScreen> {
  final _service = DraftService();
  late Future<List<ComposerDraft>> _drafts = _service.allDrafts();

  void _reload() => setState(() => _drafts = _service.allDrafts());

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Drafts'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<ComposerDraft>>(
          future: _drafts,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final drafts = snapshot.data!;
            if (drafts.isEmpty) {
              return const Center(
                child: EmptyState(
                  art: EmptyArt.drafts,
                  title: 'No drafts',
                  detail: 'Close the composer with something written and you '
                      'will be offered a draft.',
                ),
              );
            }

            return ListView.separated(
              itemCount: drafts.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: scheme.outline.withValues(alpha: 0.15),
              ),
              itemBuilder: (context, index) {
                final draft = drafts[index];
                return Dismissible(
                  key: ValueKey(draft.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: scheme.error,
                    padding: const EdgeInsets.only(
                      right: SpacingTokens.space20,
                    ),
                    child: const Icon(Iconsax.trash_copy, color: Colors.white),
                  ),
                  onDismissed: (_) async {
                    await _service.deleteDraft(draft.id!);
                    _reload();
                  },
                  child: ListTile(
                    title: Text(
                      draft.content.trim(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(_when(draft.updatedAt)),
                    onTap: () => _open(draft),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _open(ComposerDraft draft) {
    // Adopting the id, so saving updates this draft rather than adding a
    // second copy of it every time it is opened.
    _service.currentDraftId = draft.id;
    ref.read(composerProvider.notifier).updateContent(draft.content);
    Navigator.pop(context, draft);
  }

  static String _when(DateTime at) {
    final d = DateTime.now().difference(at);
    if (d.inMinutes < 1) return 'Just now';
    if (d.inHours < 1) return '${d.inMinutes} minutes ago';
    if (d.inDays < 1) return '${d.inHours} hours ago';
    if (d.inDays < 7) return '${d.inDays} days ago';
    return '${at.day}/${at.month}/${at.year}';
  }
}
