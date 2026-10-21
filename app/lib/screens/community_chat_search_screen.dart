// lib/screens/community_chat_search_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community_chat.dart';
import '../providers/community_chats_provider.dart';
import '../utils/api_error_message.dart';
import '../widgets/kyron_app_bar.dart';

/// Searching one community chat. Answers the message the reader picked, to
/// be shown where it was said, or null.
class CommunityChatSearchScreen extends ConsumerStatefulWidget {
  final String chatId;

  const CommunityChatSearchScreen({super.key, required this.chatId});

  static Future<String?> open(BuildContext context, String chatId) =>
      Navigator.of(context).push<String>(
        MaterialPageRoute(
          builder: (_) => CommunityChatSearchScreen(chatId: chatId),
        ),
      );

  @override
  ConsumerState<CommunityChatSearchScreen> createState() =>
      _CommunityChatSearchScreenState();
}

class _CommunityChatSearchScreenState
    extends ConsumerState<CommunityChatSearchScreen> {
  final _query = TextEditingController();
  Timer? _wait;
  List<CommunityChatMessage>? _found;
  String? _error;
  bool _busy = false;

  /// Counts up, so an answer to an older search cannot land over a newer.
  int _asked = 0;

  @override
  void dispose() {
    _wait?.cancel();
    _query.dispose();
    super.dispose();
  }

  void _changed(String text) {
    _wait?.cancel();
    // A beat after the last key, not on every one.
    _wait = Timer(const Duration(milliseconds: 300), () => _search(text));
  }

  Future<void> _search(String text) async {
    final words = text.trim();
    final asked = ++_asked;
    if (words.length < 2) {
      setState(() {
        _found = null;
        _error = null;
        _busy = false;
      });
      return;
    }
    setState(() => _busy = true);
    try {
      final found = await ref
          .read(communityChatsRepositoryProvider)
          .search(widget.chatId, words);
      if (!mounted || asked != _asked) return;
      setState(() {
        _found = found;
        _error = null;
        _busy = false;
      });
    } catch (error) {
      if (!mounted || asked != _asked) return;
      setState(() {
        _error = describeApiError(error, sessionIsLive: true);
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final found = _found;
    final locale = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return Scaffold(
      appBar: KyronAppBar(
        titleSpacing: 0,
        title: TextField(
          key: const ValueKey('cchat-search-field'),
          controller: _query,
          autofocus: true,
          onChanged: _changed,
          textInputAction: TextInputAction.search,
          onSubmitted: _search,
          decoration: InputDecoration(
            hintText: l10n.ui('ui_cchat_search_hint', 'Search this chat'),
            isDense: true,
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        actions: [
          if (_busy)
            const Padding(
              padding: EdgeInsets.all(SpacingTokens.space16),
              child: SizedBox.square(
                dimension: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: _error != null
          ? Padding(
              padding: const EdgeInsets.all(SpacingTokens.space24),
              child: Text(_error!, textAlign: TextAlign.center),
            )
          : found == null
              ? const SizedBox.shrink()
              : found.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(SpacingTokens.space24),
                      child: Text(
                        l10n.ui('ui_cchat_search_none', 'Nothing found.'),
                        key: const ValueKey('cchat-search-none'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: scheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: found.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 0.5,
                        thickness: 0.5,
                        indent: SpacingTokens.space16,
                        color: scheme.outline.withValues(alpha: 0.15),
                      ),
                      itemBuilder: (context, index) {
                        final message = found[index];
                        return ListTile(
                          key: ValueKey('cchat-found-${message.id}'),
                          onTap: () => Navigator.pop(context, message.id),
                          title: Text(
                            message.sender.displayName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            message.body,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            DateFormat.MMMd(locale).format(message.createdAt),
                            style: TextStyle(
                              fontSize: TypographyTokens.fontSize1,
                              color: scheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
