// lib/screens/chat_wallpaper_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../models/chat_wallpaper.dart';
import '../providers/chat_wallpaper_provider.dart';
import '../widgets/chat_wallpaper_view.dart';
import '../widgets/hairline.dart';
import '../widgets/kyron_app_bar.dart';

/// Chooses what one conversation is drawn on.
///
/// The choice is shown on a small copy of the conversation at the top --
/// two bubbles on the wallpaper -- because a swatch says what a wallpaper
/// looks like and not whether a message can still be read on it. It is
/// applied the moment it is tapped: there is nothing to confirm, and the
/// way back is the same tap on another one.
class ChatWallpaperScreen extends ConsumerWidget {
  final String conversationId;

  const ChatWallpaperScreen({super.key, required this.conversationId});

  static Future<void> open(
    BuildContext context, {
    required String conversationId,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (_) => ChatWallpaperScreen(conversationId: conversationId),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final chosen = ref.watch(chatWallpaperProvider(conversationId));
    final remote = ref.watch(remoteWallpapersProvider).asData?.value ??
        const <RemoteWallpaper>[];
    final notifier = ref.read(chatWallpaperProvider(conversationId).notifier);

    final options = <(ChatWallpaper, String)>[
      (ChatWallpaper.none, l10n.ui('ui_dm_wallpaper_none', 'None')),
      for (final builtIn in BuiltInWallpaper.values)
        (ChatWallpaper.builtIn(builtIn), builtInWallpaperName(l10n, builtIn)),
      for (final image in remote) (ChatWallpaper.image(image.url), image.label),
    ];

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.ui('ui_dm_info_wallpaper', 'Wallpaper')),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Preview(wallpaper: chosen)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              SpacingTokens.space16,
              SpacingTokens.space8,
              SpacingTokens.space16,
              SpacingTokens.space32,
            ),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: SpacingTokens.space12,
                crossAxisSpacing: SpacingTokens.space12,
                // A phone's shape, so the swatch reads as a screen.
                childAspectRatio: 0.56,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final (wallpaper, label) = options[index];
                return _Option(
                  key: ValueKey('wallpaper-${wallpaper.key}'),
                  wallpaper: wallpaper,
                  label: label,
                  selected: wallpaper == chosen,
                  onTap: () => notifier.choose(wallpaper),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A sliver of the conversation on the chosen wallpaper: one message from
/// them and one from you.
class _Preview extends StatelessWidget {
  final ChatWallpaper wallpaper;

  const _Preview({required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    Widget bubble(String text, {required bool mine}) => Align(
          alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 240),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: mine ? scheme.primary : scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(RadiusTokens.radius20),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize3,
                color: mine ? scheme.onPrimary : scheme.onSurface,
              ),
            ),
          ),
        );

    return Padding(
      padding: const EdgeInsets.all(SpacingTokens.space16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RadiusTokens.radius20),
        child: SizedBox(
          height: 200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedSwitcher(
                duration: MotionTokens.normal,
                child: ChatWallpaperView(
                  key: ValueKey(wallpaper.key),
                  wallpaper: wallpaper,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingTokens.space16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    bubble(
                      l10n.ui(
                        'ui_dm_wallpaper_sample_theirs',
                        'This is how your chat will look.',
                      ),
                      mine: false,
                    ),
                    const SizedBox(height: SpacingTokens.space8),
                    bubble(
                      l10n.ui('ui_dm_wallpaper_sample_mine', 'Looks good.'),
                      mine: true,
                    ),
                  ],
                ),
              ),
              DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RadiusTokens.radius20),
                  border: Border.fromBorderSide(postRule(scheme)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final ChatWallpaper wallpaper;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Option({
    super.key,
    required this.wallpaper,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final width = (120 * MediaQuery.devicePixelRatioOf(context)).round();

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: MotionTokens.fast,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(RadiusTokens.radiusMd + 3),
                  border: Border.all(
                    color: selected ? scheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(RadiusTokens.radiusMd),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ChatWallpaperView(
                        wallpaper: wallpaper,
                        decodeWidth: width,
                      ),
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(RadiusTokens.radiusMd),
                          border: Border.fromBorderSide(postRule(scheme)),
                        ),
                      ),
                      if (selected)
                        Positioned(
                          right: SpacingTokens.space8,
                          bottom: SpacingTokens.space8,
                          child: Icon(
                            Iconsax.tick_circle,
                            size: 22,
                            color: scheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: SpacingTokens.space4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: TypographyTokens.fontSize1,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A built-in wallpaper's name, in the reader's language.
String builtInWallpaperName(
        AppLocalizations l10n, BuiltInWallpaper wallpaper) =>
    switch (wallpaper) {
      BuiltInWallpaper.mist => l10n.ui('ui_wallpaper_mist', 'Mist'),
      BuiltInWallpaper.dusk => l10n.ui('ui_wallpaper_dusk', 'Dusk'),
      BuiltInWallpaper.sage => l10n.ui('ui_wallpaper_sage', 'Sage'),
      BuiltInWallpaper.sand => l10n.ui('ui_wallpaper_sand', 'Sand'),
      BuiltInWallpaper.dots => l10n.ui('ui_wallpaper_dots', 'Dots'),
    };
