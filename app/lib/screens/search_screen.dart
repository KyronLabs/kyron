// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../models/profile_summary.dart';
import '../providers/search_provider.dart';
import '../routes.dart';
import '../utils/format_count.dart';

/// Finding people. The search icon in the top bar used to print "Search" to
/// the debug console and nothing else.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // The screen exists to be typed into, so it opens with the keyboard up.
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          focusNode: _focus,
          textInputAction: TextInputAction.search,
          onChanged: ref.read(searchProvider.notifier).query,
          decoration: InputDecoration(
            hintText: 'Search people',
            border: InputBorder.none,
            suffixIcon: state.isIdle
                ? null
                : IconButton(
                    icon: const Icon(Iconsax.close_circle, size: 18),
                    tooltip: 'Clear',
                    onPressed: () {
                      _controller.clear();
                      ref.read(searchProvider.notifier).clear();
                    },
                  ),
          ),
        ),
      ),
      body: SafeArea(child: _body(state)),
    );
  }

  Widget _body(SearchState state) {
    if (state.isIdle) {
      return const _Hint(
        icon: Iconsax.search_normal_1,
        title: 'Find people on Kyron',
        detail: 'Search by handle or display name.',
      );
    }
    if (state.isTooShort) {
      return const _Hint(
        icon: Iconsax.keyboard,
        title: 'Keep typing',
        detail: 'Two characters or more.',
      );
    }
    if (state.error != null) {
      return _Hint(
        icon: Icons.cloud_off_outlined,
        title: 'Search failed',
        detail: state.error!,
        action: 'Try again',
        onAction: ref.read(searchProvider.notifier).retry,
      );
    }
    if (state.isSearching && state.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.foundNothing) {
      return _Hint(
        icon: Iconsax.user_search,
        title: 'No one matched',
        detail: 'Nobody on Kyron matches "${state.query.trim()}".',
      );
    }

    return ListView.builder(
      itemCount: state.results.length,
      itemBuilder: (context, index) => _Result(person: state.results[index]),
    );
  }
}

class _Result extends StatelessWidget {
  final ProfileSummary person;

  const _Result({required this.person});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final handle = person.handle;
    final bio = person.bio?.trim();

    return ListTile(
      onTap: handle == null
          ? null
          : () => Navigator.pushNamed(
                context,
                Routes.profile,
                arguments: person.username,
              ),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: scheme.primary.withValues(alpha: 0.2),
        foregroundImage:
            person.avatarUrl == null ? null : NetworkImage(person.avatarUrl!),
        child: Icon(Iconsax.user, size: 20, color: scheme.primary),
      ),
      title: Text(
        person.displayName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            [
              if (handle != null) handle,
              '${formatCount(person.followers)} followers',
            ].join(' · '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (bio != null && bio.isNotEmpty)
            Text(bio, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
      isThreeLine: bio != null && bio.isNotEmpty,
    );
  }
}

class _Hint extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final String? action;
  final VoidCallback? onAction;

  const _Hint({
    required this.icon,
    required this.title,
    required this.detail,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingTokens.space32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 44, color: scheme.onSurface.withValues(alpha: .35)),
            const SizedBox(height: SpacingTokens.space16),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: .7),
                  ),
            ),
            if (action != null) ...[
              const SizedBox(height: SpacingTokens.space16),
              TextButton(onPressed: onAction, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}
