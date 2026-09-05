import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/onboarding_model.dart';
import '../models/profile_summary.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';
import '../services/profile_service.dart';
import '../widgets/atomic_card.dart';
import '../services/app_log.dart';
import '../utils/api_error_message.dart';

class OnboardStep3Screen extends ConsumerStatefulWidget {
  final OnboardingModel model;
  const OnboardStep3Screen({super.key, required this.model});

  @override
  ConsumerState<OnboardStep3Screen> createState() => _OnboardStep3ScreenState();
}

class _OnboardStep3ScreenState extends ConsumerState<OnboardStep3Screen> {
  final _profileService = ProfileService();

  /// See [_OnboardStep1ScreenState]: a 401 while the session is valid is the
  /// server refusing a good token, not an expired sign-in.
  bool get _sessionIsLive => ref.read(authRepositoryProvider).hasValidSession;

  bool _loadingSuggestions = true;
  bool _finishing = false;

  List<ProfileSummary> _suggested = [];

  /// Who has been picked here, so a card can show its own state without the
  /// list being rebuilt from the server after every tap.
  final Set<String> _picked = {};

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    try {
      final users = await _profileService.getSuggestedUsers();
      if (!mounted) return;
      setState(() {
        _suggested = users;
        _loadingSuggestions = false;
      });
    } catch (e) {
      // Suggestions are optional; the step still works without them. Recorded
      // rather than printed, so it is still there in About > System log.
      AppLog.instance.error('onboarding', 'Suggestions would not load: $e');
      if (!mounted) return;
      setState(() => _loadingSuggestions = false);
    }
  }

  void _toggle(ProfileSummary person) {
    setState(() {
      if (_picked.remove(person.id)) {
        widget.model.followedAccounts.remove(person.id);
      } else {
        _picked.add(person.id);
        widget.model.followedAccounts.add(person.id);
      }
    });
  }

  Future<void> _finish() async {
    setState(() => _finishing = true);

    try {
      // Following suggestions is optional. It used to share a try with the
      // steps below under a catch that only debugPrinted, so a failed follow
      // meant onboarding was never marked complete and nothing navigated --
      // leaving the user stuck on the last screen of the flow with no message.
      if (widget.model.followedAccounts.isNotEmpty) {
        try {
          await _profileService.followSuggested(widget.model.followedAccounts);
        } catch (e) {
          debugPrint('step3: followSuggested failed: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Could not follow everyone: '
                  '${describeApiError(e, sessionIsLive: _sessionIsLive)}',
                ),
              ),
            );
          }
        }
      }

      // Finishing onboarding is local state, so this should not fail -- but if
      // it does, still let the user through rather than trapping them here.
      try {
        await ref.read(authRepositoryProvider).setOnboardingCompleted();
      } catch (e) {
        debugPrint('step3: setOnboardingCompleted failed: $e');
      }

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
      }
    } finally {
      if (mounted) setState(() => _finishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover people"),
        actions: [TextButton(onPressed: _finish, child: const Text("Skip"))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Follow accounts you find interesting",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 6),
            Text(
              "You can always change this later.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            /* ---------- Loading State ---------- */
            if (_loadingSuggestions)
              const Center(child: CircularProgressIndicator()),

            /* ---------- Suggestions Grid ---------- */
            if (!_loadingSuggestions)
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 150,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _suggested.length,
                  itemBuilder: (_, i) {
                    final person = _suggested[i];
                    return AtomicCard(
                      avatarUrl: person.avatarUrl ?? '',
                      handle: person.handle ?? person.displayName,
                      bio: person.bio,
                      isInitiallyFollowing: _picked.contains(person.id),
                      onFollowToggle: () => _toggle(person),
                      onTap: () => openProfile(
                        context,
                        username: person.username,
                        userId: person.id,
                      ),
                    );
                  },
                ),
              ),

            /* ---------- Finish Button ---------- */
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _finish,
                child: _finishing
                    ? const CircularProgressIndicator()
                    : const Text("Finish"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
