import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// StoryStatus is DEFINED HERE ONLY - the source of truth
enum StoryStatus {
  yourStory,
  unseen,
  seen,
  expired,
  uploading,
}

class Story {
  final String id;
  final String handle;
  final String? avatarUrl;
  final StoryStatus status;
  final DateTime? createdAt;
  final bool isYourStory;

  const Story({
    required this.id,
    required this.handle,
    this.avatarUrl,
    required this.status,
    this.createdAt,
    this.isYourStory = false,
  });
}

class StoriesNotifier extends StateNotifier<AsyncValue<List<Story>>> {
  StoriesNotifier() : super(const AsyncValue.loading()) {
    _loadStories();
  }

  Future<void> _loadStories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // ✅ Removed const keyword, added real DateTime values
    state = AsyncValue.data([
      Story(
        id: 'your_story',
        handle: 'you',
        status: StoryStatus.yourStory,
        createdAt: DateTime.now(),
        isYourStory: true,
      ),
      Story(
        id: '1',
        handle: 'alice',
        avatarUrl: 'https://example.com/alice.jpg',
        status: StoryStatus.unseen,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Story(
        id: '2',
        handle: 'bob_longhandle',
        avatarUrl: 'https://example.com/bob.jpg',
        status: StoryStatus.seen,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Story(
        id: '3',
        handle: 'charlie',
        avatarUrl: 'https://example.com/charlie.jpg',
        status: StoryStatus.unseen,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Story(
        id: '4',
        handle: 'diana',
        avatarUrl: 'https://example.com/diana.jpg',
        status: StoryStatus.expired,
        createdAt: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      Story(
        id: '5',
        handle: 'eve',
        avatarUrl: 'https://example.com/eve.jpg',
        status: StoryStatus.unseen,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ]);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _loadStories();
  }
}

// ✅ ADDED: The missing provider declaration
final storiesProvider = StateNotifierProvider<StoriesNotifier, AsyncValue<List<Story>>>((ref) {
  return StoriesNotifier();
});