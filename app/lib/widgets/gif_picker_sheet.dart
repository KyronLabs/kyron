import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';
import 'package:path_provider/path_provider.dart';

import '../services/gif_search.dart';
import 'toast.dart';

/// Picking a GIF. Returns the path of the downloaded file, ready to attach.
///
/// Downloaded and then uploaded like any other attachment rather than posting
/// the provider's URL: a post that links to somebody else's CDN breaks when
/// they rotate it, and hands them a view of everyone who scrolls past.
class GifPickerSheet {
  const GifPickerSheet._();

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _Sheet(),
    );
  }
}

class _Sheet extends StatefulWidget {
  const _Sheet();

  @override
  State<_Sheet> createState() => _SheetState();
}

class _SheetState extends State<_Sheet> {
  final _search = GifSearch();
  final _controller = TextEditingController();

  Timer? _debounce;
  List<GifResult> _results = const [];
  bool _loading = true;
  String? _error;
  String? _downloading;

  @override
  void initState() {
    super.initState();
    _load(null);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load(String? query) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = query == null || query.trim().isEmpty
          ? await _search.featured()
          : await _search.search(query.trim());
      if (!mounted) return;
      setState(() {
        _results = results;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Could not reach the GIF library.';
      });
    }
  }

  void _query(String value) {
    _debounce?.cancel();
    // A request per keystroke would send six for "party", five thrown away.
    _debounce = Timer(const Duration(milliseconds: 350), () => _load(value));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingTokens.space16,
              ),
              child: TextField(
                controller: _controller,
                autofocus: GifSearch.isConfigured,
                enabled: GifSearch.isConfigured,
                onChanged: _query,
                decoration: const InputDecoration(
                  hintText: 'Search GIFs',
                  prefixIcon: Icon(Iconsax.search_normal_1_copy, size: 18),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(height: SpacingTokens.space12),
            Expanded(child: _body(scheme)),
          ],
        ),
      ),
    );
  }

  Widget _body(ColorScheme scheme) {
    if (!GifSearch.isConfigured) {
      // Said plainly rather than shown as an empty grid, which reads as a
      // network fault the reader could do something about.
      return _Notice(
        icon: Iconsax.key_copy,
        title: 'GIFs are not set up',
        detail: 'This build has no TENOR_API_KEY, so the GIF library cannot '
            'be searched. Pass one at build time to turn this on.',
      );
    }
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return _Notice(
        icon: Icons.cloud_off_outlined,
        title: 'Could not load GIFs',
        detail: _error!,
        onRetry: () => _load(_controller.text),
      );
    }
    if (_results.isEmpty) {
      return const _Notice(
        icon: Iconsax.emoji_normal_copy,
        title: 'Nothing found',
        detail: 'Try a different search.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: SpacingTokens.space12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final gif = _results[index];
        final busy = _downloading == gif.id;

        return GestureDetector(
          onTap: busy ? null : () => _choose(gif),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
                child: Image.network(
                  gif.previewUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      ColoredBox(color: scheme.surfaceContainerHighest),
                ),
              ),
              if (busy)
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(RadiusTokens.radiusSm),
                  ),
                  child: const Center(
                    child: SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _choose(GifResult gif) async {
    setState(() => _downloading = gif.id);
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/gif_${gif.id}.gif');
      await Dio().download(gif.url, file.path);
      if (!mounted) return;
      Navigator.pop(context, file.path);
    } catch (_) {
      if (!mounted) return;
      setState(() => _downloading = null);
      Toast.show(context, 'That GIF could not be downloaded.');
    }
  }
}

class _Notice extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final VoidCallback? onRetry;

  const _Notice({
    required this.icon,
    required this.title,
    required this.detail,
    this.onRetry,
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
                size: 40, color: scheme.onSurface.withValues(alpha: .35)),
            const SizedBox(height: SpacingTokens.space12),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: SpacingTokens.space8),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: .7)),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: SpacingTokens.space12),
              TextButton(onPressed: onRetry, child: const Text('Try again')),
            ],
          ],
        ),
      ),
    );
  }
}
