import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/onboarding_model.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/api_error_message.dart';
import '../widgets/app_button.dart';
import '../widgets/gradient_scaffold.dart';
import '../services/profile_service.dart';

/// One row of the `interests` table. The screen shows [name] and sends [slug]:
/// the API matches submitted values against slug, so sending the display label
/// silently dropped any tag whose label did not happen to equal its slug --
/// Technology, Photography, Fitness and Books all failed that way, and picking
/// only those made the whole step fail with "No valid interests found".
class InterestOption {
  final String slug;
  final String name;
  const InterestOption({required this.slug, required this.name});
}

class OnboardStep2Screen extends StatefulWidget {
  final OnboardingModel model;
  const OnboardStep2Screen({super.key, required this.model});

  @override
  State<OnboardStep2Screen> createState() => _OnboardStep2ScreenState();
}

class _OnboardStep2ScreenState extends State<OnboardStep2Screen> {
  final _profileService = ProfileService();

  List<InterestOption> _options = const [];
  bool _isLoading = false;
  bool _isLoadingOptions = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadInterests();
  }

  /// Read straight from Supabase rather than hardcoding a list that drifts from
  /// the table. `interests` is reference data with a public select policy, so
  /// this needs no session and does not depend on the API being up.
  Future<void> _loadInterests() async {
    setState(() {
      _isLoadingOptions = true;
      _loadError = null;
    });
    try {
      final rows = await Supabase.instance.client
          .from('interests')
          .select('slug, name')
          .order('name');

      final options = [
        for (final row in rows)
          InterestOption(
            slug: row['slug'] as String,
            name: row['name'] as String,
          ),
      ];

      if (!mounted) return;
      setState(() {
        _options = options;
        _isLoadingOptions = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError = describeApiError(e);
        _isLoadingOptions = false;
      });
    }
  }

  void _toggle(String slug) {
    setState(() {
      if (widget.model.interests.contains(slug)) {
        widget.model.interests.remove(slug);
      } else {
        widget.model.interests.add(slug);
      }
    });
  }

  Future<void> _handleNavigation(
    BuildContext context,
    String routeName,
    Object? arguments, {
    bool saveInterests = true,
  }) async {
    setState(() => _isLoading = true);

    try {
      if (saveInterests && widget.model.interests.isNotEmpty) {
        await _profileService.saveInterests(widget.model.interests);
      }

      if (mounted) {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      }
    } catch (e) {
      debugPrint('step2: saving interests failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(describeApiError(e))));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _next() async {
    await _handleNavigation(context, Routes.onboardStep3, widget.model);
  }

  /// Skip means skip: it used to still save whatever was selected, so tapping
  /// it after picking a tag did the work anyway and could fail on the way out.
  Future<void> _skip() async {
    await _handleNavigation(context, Routes.home, null, saveInterests: false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return GradientScaffold(
      appBar: AppBar(
        title: const Text('Pick your interests'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _skip,
            child: const Text(
              'Skip',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        // Top padding was 0, so the heading sat flush against the app bar.
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What do you love?',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Select a few topics to personalise your feed.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Expanded(child: _buildOptions(scheme, isDark)),
            const SizedBox(height: 16),
            AppButton(
              label: 'Next',
              onTap: _next,
              isLoading: _isLoading,
              // Nothing selected has nothing to save; Skip is the way past.
              enabled: widget.model.interests.isNotEmpty,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(ColorScheme scheme, bool isDark) {
    if (_isLoadingOptions) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_loadError != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_loadError!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextButton(onPressed: _loadInterests, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (_options.isEmpty) {
      return const Center(child: Text('No interests are available yet.'));
    }

    return SingleChildScrollView(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: _options.map((option) {
          final selected = widget.model.interests.contains(option.slug);
          return _buildTag(option, selected, scheme, isDark);
        }).toList(),
      ),
    );
  }

  Widget _buildTag(
    InterestOption option,
    bool selected,
    ColorScheme scheme,
    bool isDark,
  ) {
    final bg = selected
        ? scheme.primary.withValues(alpha: .12)
        : (isDark ? AppTheme.surface : AppTheme.lightSurface);
    final fg = selected ? scheme.primary : scheme.onSurface;

    return GestureDetector(
      onTap: _isLoading ? null : () => _toggle(option.slug),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? scheme.primary.withValues(alpha: .35)
                : (isDark
                    ? Colors.transparent
                    : scheme.onSurface.withValues(alpha: .12)),
            width: 1,
          ),
        ),
        child: Text(
          option.name,
          style: TextStyle(
            color: fg,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
