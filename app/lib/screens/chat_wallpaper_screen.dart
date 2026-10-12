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
import '../widgets/skeleton.dart';

/// Chooses what one conversation is drawn on.
///
/// A tap previews; Apply, at the top right, is what changes the
/// conversation. The preview -- two bubbles on the wallpaper -- stays put at
/// the top while the choices scroll under it, so every one can be seen as a
/// conversation rather than as a swatch, without scrolling back up to check.
/// The one being previewed is ringed in the accent; the one the conversation
/// already has is marked Current, so the two can never be confused.
class ChatWallpaperScreen extends ConsumerStatefulWidget {
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

  /// How many placeholders stand in for the folder while it loads.
  static const int skeletonCount = 6;

  @override
  ConsumerState<ChatWallpaperScreen> createState() =>
      _ChatWallpaperScreenState();
}

class _ChatWallpaperScreenState extends ConsumerState<ChatWallpaperScreen> {
  /// What the preview shows. Null until the reader picks something: until
  /// then it is whatever the conversation already has.
  ChatWallpaper? _previewing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final current = ref.watch(chatWallpaperProvider(widget.conversationId));
    final remote = ref.watch(remoteWallpapersProvider);
    final previewing = _previewing ?? current;
    final changed = previewing != current;

    final options = <(ChatWallpaper, String?)>[
      (ChatWallpaper.none, l10n.ui('ui_dm_wallpaper_none', 'None')),
      for (final builtIn in BuiltInWallpaper.values)
        (ChatWallpaper.builtIn(builtIn), builtInWallpaperName(l10n, builtIn)),
      for (final image in remote.asData?.value ?? const <RemoteWallpaper>[])
        (ChatWallpaper.image(image.url), image.label),
    ];
    final loading = remote.isLoading;

    return Scaffold(
      appBar: KyronAppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_copy),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.ui('ui_dm_info_wallpaper', 'Wallpaper')),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingTokens.space8),
            child: TextButton(
              key: const ValueKey('wallpaper-apply'),
              // Only once there is something to change to: applying what is
              // already there would be a button that does nothing.
              onPressed: changed ? () => _apply(previewing) : null,
              style: TextButton.styleFrom(
                foregroundColor: scheme.primary,
                textStyle: const TextStyle(
                  fontSize: TypographyTokens.fontSize3,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(l10n.ui('ui_dm_wallpaper_apply', 'Apply')),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _Preview(wallpaper: previewing),
          const Hairline(),
          Expanded(
            child: _Shimmer(
              // Only while there is something to shimmer: the group's ticker
              // repeats forever, and left running under a loaded grid it
              // repaints the screen for nothing.
              active: loading,
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(
                  SpacingTokens.space16,
                  SpacingTokens.space16,
                  SpacingTokens.space16,
                  SpacingTokens.space32,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: SpacingTokens.space12,
                  crossAxisSpacing: SpacingTokens.space12,
                  // A phone's shape, so the swatch reads as a screen.
                  childAspectRatio: 0.56,
                ),
                itemCount: options.length +
                    (loading ? ChatWallpaperScreen.skeletonCount : 0),
                itemBuilder: (context, index) {
                  if (index >= options.length) {
                    return const _OptionSkeleton();
                  }
                  final (wallpaper, label) = options[index];
                  return _Option(
                    key: ValueKey('wallpaper-${wallpaper.key}'),
                    wallpaper: wallpaper,
                    label: label,
                    previewing: wallpaper == previewing,
                    current: wallpaper == current,
                    onTap: () => setState(() => _previewing = wallpaper),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _apply(ChatWallpaper wallpaper) async {
    await ref
        .read(chatWallpaperProvider(widget.conversationId).notifier)
        .choose(wallpaper);
    if (mounted) Navigator.pop(context);
  }
}

/// A sliver of the conversation on the wallpaper being looked at: one
/// message from them and one from you, drawn as the thread draws them.
class _Preview extends StatelessWidget {
  final ChatWallpaper wallpaper;

  const _Preview({required this.wallpaper});

  /// Tall enough to read two bubbles on, short enough to leave most of the
  /// screen to the choices.
  static const double height = 176;

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
      padding: const EdgeInsets.fromLTRB(
        SpacingTokens.space16,
        SpacingTokens.space8,
        SpacingTokens.space16,
        SpacingTokens.space16,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RadiusTokens.radius20),
        child: SizedBox(
          height: height,
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
  final String? label;

  /// Shown in the preview: ringed in the accent.
  final bool previewing;

  /// What the conversation has now: marked Current.
  final bool current;
  final VoidCallback onTap;

  const _Option({
    super.key,
    required this.wallpaper,
    required this.label,
    required this.previewing,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final width = (120 * MediaQuery.devicePixelRatioOf(context)).round();
    final label = this.label;

    return Semantics(
      button: true,
      selected: previewing,
      label: [
        if (label != null) label,
        if (current) l10n.ui('ui_dm_wallpaper_current', 'Current'),
      ].join(', '),
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
                    color: previewing ? scheme.primary : Colors.transparent,
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
                      // The one the conversation has now. A label on a dark
                      // pill rather than a second tick, so it cannot be read
                      // as "selected" -- that is the ring's job.
                      if (current)
                        Positioned(
                          left: SpacingTokens.space8,
                          top: SpacingTokens.space8,
                          child: _CurrentTag(
                            text: l10n.ui('ui_dm_wallpaper_current', 'Current'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
              child: label == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(top: SpacingTokens.space4),
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: TypographyTokens.fontSize1,
                          fontWeight:
                              previewing ? FontWeight.w700 : FontWeight.w500,
                          color: previewing ? scheme.primary : null,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentTag extends StatelessWidget {
  final String text;

  const _CurrentTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingTokens.space8,
        vertical: SpacingTokens.space2,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(RadiusTokens.radiusFull),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: TypographyTokens.fontSize0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// The skeletons' shared shimmer, mounted only while [active].
class _Shimmer extends StatelessWidget {
  final bool active;
  final Widget child;

  const _Shimmer({required this.active, required this.child});

  @override
  Widget build(BuildContext context) =>
      active ? SkeletonGroup(child: child) : child;
}

/// A swatch-shaped placeholder while the folder's wallpapers load.
class _OptionSkeleton extends StatelessWidget {
  const _OptionSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.5),
            child: LayoutBuilder(
              builder: (context, constraints) => SkeletonBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                radius: RadiusTokens.radiusMd,
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
      ],
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
