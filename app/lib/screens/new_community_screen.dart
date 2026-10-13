// lib/screens/new_community_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/community.dart';
import '../providers/communities_provider.dart';
import '../routes.dart';
import '../utils/api_error_message.dart';
import '../widgets/kyron_app_bar.dart';
import '../widgets/toast.dart';

/// Starts a community: a name, the address it will have -- shown while the
/// name is typed, not after the fact -- and what it is for.
///
/// A page of its own, opened from the bar at the top of Communities. It was a
/// sheet behind a floating button, which the keyboard pushed half off the
/// screen and the bottom bar half covered.
class NewCommunityScreen extends ConsumerStatefulWidget {
  const NewCommunityScreen({super.key});

  @override
  ConsumerState<NewCommunityScreen> createState() => _NewCommunityScreenState();
}

class _NewCommunityScreenState extends ConsumerState<NewCommunityScreen> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  /// The same rule the server applies, so what is shown is what will happen.
  String get _slug => _name.text
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');

  bool get _canCreate => _slug.isNotEmpty && !_busy;

  Future<void> _create() async {
    if (!_canCreate) return;
    setState(() => _busy = true);
    try {
      final Community created = await ref
          .read(communitiesRepositoryProvider)
          .create(_name.text, description: _description.text);
      if (!mounted) return;
      ref
          .read(myCommunitiesProvider(CommunityFilter.all).notifier)
          .add(created);
      // In place of this page: back from the new community is back to the
      // list, not to a form that has done its job.
      await Navigator.pushReplacementNamed(
        context,
        Routes.community,
        arguments: created.slug,
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _busy = false);
      Toast.show(context, describeApiError(error, sessionIsLive: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: KyronAppBar(
        title: Text(l10n.ui('ui_community_new', 'New community')),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space16,
          SpacingTokens.space24,
        ),
        children: [
          TextField(
            key: const ValueKey('new-community-name'),
            controller: _name,
            autofocus: true,
            maxLength: 60,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.ui('ui_community_name', 'Name'),
              hintText: l10n.lagosDesign,
              counterText: '',
            ),
          ),
          const SizedBox(height: SpacingTokens.space4),
          Text(
            _slug.isEmpty
                ? l10n.ui(
                    'ui_community_address_hint',
                    'Its address is made from the name.',
                  )
                : '${l10n.ui('ui_community_address', 'People will find it at')} c/$_slug',
            key: const ValueKey('new-community-address'),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: SpacingTokens.space16),
          TextField(
            key: const ValueKey('new-community-description'),
            controller: _description,
            maxLength: 400,
            maxLines: 4,
            minLines: 2,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.ui(
                'ui_communities_screen_what_is_it_for_optional_39b687',
                'What is it for? (optional)',
              ),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: SpacingTokens.space8),
          Text(
            l10n.ui(
              'ui_community_new_detail',
              'You will own it. A picture, a banner and moderators can be '
                  'added from its page once it exists.',
            ),
            style: TextStyle(
              fontSize: TypographyTokens.fontSize1,
              height: 1.4,
              color: scheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: SpacingTokens.space24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              key: const ValueKey('new-community-create'),
              onPressed: _canCreate ? _create : null,
              child: _busy
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.create),
            ),
          ),
        ],
      ),
    );
  }
}
