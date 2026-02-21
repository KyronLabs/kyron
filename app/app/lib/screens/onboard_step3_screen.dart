import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/onboarding_model.dart';
import '../models/suggested_user.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';
import '../services/profile_service.dart';
import '../widgets/atomic_card.dart';

class OnboardStep3Screen extends ConsumerStatefulWidget {
  final OnboardingModel model;
  const OnboardStep3Screen({super.key, required this.model});

  @override
  ConsumerState<OnboardStep3Screen> createState() =>
      _OnboardStep3ScreenState();
}

class _OnboardStep3ScreenState extends ConsumerState<OnboardStep3Screen> {
  final _profileService = ProfileService();

  bool _loadingSuggestions = true;
  bool _finishing = false;

  List<SuggestedUser> _suggested = [];

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    try {
      final users = await _profileService.getSuggestedUsers();
      setState(() {
        _suggested = users;
        _loadingSuggestions = false;
      });
    } catch (e) {
      debugPrint('ERROR SUGGESTIONS: $e');
      setState(() => _loadingSuggestions = false);
    }
  }

  void _toggle(SuggestedUser u) {
    setState(() {
      u.isFollowing = !u.isFollowing;

      if (u.isFollowing) {
        widget.model.followedAccounts.add(u.id);
      } else {
        widget.model.followedAccounts.remove(u.id);
      }
    });
  }

  Future<void> _finish() async {
    setState(() => _finishing = true);

    try {
      if (widget.model.followedAccounts.isNotEmpty) {
        await _profileService.followSuggested(widget.model.followedAccounts);
      }

      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.setOnboardingCompleted();

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
          (_) => false,
        );
      }
    } catch (e) {
      debugPrint("ONBOARD STEP 3 ERROR: $e");
    } finally {
      if (mounted) setState(() => _finishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover people"),
        actions: [
          TextButton(
            onPressed: _finish,
            child: const Text("Skip"),
          )
        ],
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
                    final u = _suggested[i];
                    return AtomicCard(
                      avatarUrl: u.avatar ?? "",
                      handle: u.handle,
                      bio: u.bio,
                      isInitiallyFollowing: u.isFollowing,
                      onFollowToggle: () => _toggle(u),
                      onTap: () {},     // Open profile preview later
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
            )
          ],
        ),
      ),
    );
  }
}
