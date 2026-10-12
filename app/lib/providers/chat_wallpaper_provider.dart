// lib/providers/chat_wallpaper_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_wallpaper.dart';
import 'messages_provider.dart' show messagesRepositoryProvider;

/// The wallpaper chosen for one conversation, on this phone.
///
/// Starts as the plain page and fills in from storage a moment later; a
/// conversation opening on its plain page for one frame is better than one
/// that waits for a disk read before it can draw anything.
class ChatWallpaperNotifier extends StateNotifier<ChatWallpaper> {
  ChatWallpaperNotifier(this.conversationId) : super(ChatWallpaper.none) {
    _load();
  }

  final String conversationId;

  static String keyFor(String conversationId) =>
      'chat_wallpaper_$conversationId';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    state = ChatWallpaper.fromKey(prefs.getString(keyFor(conversationId)));
  }

  Future<void> choose(ChatWallpaper wallpaper) async {
    state = wallpaper;
    final prefs = await SharedPreferences.getInstance();
    if (wallpaper.isNone) {
      await prefs.remove(keyFor(conversationId));
    } else {
      await prefs.setString(keyFor(conversationId), wallpaper.key);
    }
  }
}

final chatWallpaperProvider =
    StateNotifierProvider.family<ChatWallpaperNotifier, ChatWallpaper, String>(
  (ref, conversationId) => ChatWallpaperNotifier(conversationId),
);

/// The images in the wallpapers folder. Empty, not an error, when there are
/// none or they cannot be fetched: the built-in ones are always there.
final remoteWallpapersProvider = FutureProvider<List<RemoteWallpaper>>((
  ref,
) async {
  try {
    return await ref.read(messagesRepositoryProvider).wallpapers();
  } catch (_) {
    return const [];
  }
});
