// lib/models/chat_wallpaper.dart
import 'package:flutter/material.dart';

/// The wallpapers drawn in the app itself, which need nothing from the
/// network and so are there on a first launch, offline, and before anybody
/// has put an image in the wallpapers folder.
///
/// Each is a quiet two-stop wash with a light and a dark version, chosen so
/// both kinds of bubble stay legible on it. A wallpaper is behind every
/// message in a conversation; anything louder than this competes with them.
enum BuiltInWallpaper {
  mist(
    light: [Color(0xFFE8F1FF), Color(0xFFF7FAFE)],
    dark: [Color(0xFF0E1928), Color(0xFF0A0E15)],
  ),
  dusk(
    light: [Color(0xFFF3E8FD), Color(0xFFFFF0F5)],
    dark: [Color(0xFF1D1128), Color(0xFF160D1B)],
  ),
  sage(
    light: [Color(0xFFE6F4EC), Color(0xFFF5FAF2)],
    dark: [Color(0xFF0E1D16), Color(0xFF0B130F)],
  ),
  sand(
    light: [Color(0xFFFAF0E1), Color(0xFFFFF8EE)],
    dark: [Color(0xFF211910), Color(0xFF15110B)],
  ),

  /// The page's own colour with a fine grid of dots: texture without colour.
  dots(light: [], dark: []);

  const BuiltInWallpaper({required this.light, required this.dark});

  final List<Color> light;
  final List<Color> dark;
}

/// What one conversation is drawn on.
///
/// Stored as a single string so it can live in device preferences: the
/// chosen wallpaper is this phone's choice for this conversation, the way it
/// is in every messenger, and not something the other person sees or the
/// server needs to hold.
@immutable
class ChatWallpaper {
  const ChatWallpaper._(this.key);

  /// The plain page. What every conversation starts with.
  static const none = ChatWallpaper._('none');

  factory ChatWallpaper.builtIn(BuiltInWallpaper wallpaper) =>
      ChatWallpaper._('builtin:${wallpaper.name}');

  /// One of the images from the wallpapers folder.
  factory ChatWallpaper.image(String url) => ChatWallpaper._('url:$url');

  /// Reads back what [key] wrote. Anything unrecognised -- a built-in that
  /// has since been removed, a value from a future version -- is the plain
  /// page rather than an error.
  factory ChatWallpaper.fromKey(String? key) {
    if (key == null) return none;
    if (key.startsWith('url:') && key.length > 4) return ChatWallpaper._(key);
    if (key.startsWith('builtin:')) {
      final name = key.substring('builtin:'.length);
      for (final wallpaper in BuiltInWallpaper.values) {
        if (wallpaper.name == name) return ChatWallpaper._(key);
      }
    }
    return none;
  }

  final String key;

  bool get isNone => key == none.key;

  /// The image's address, for one from the folder.
  String? get imageUrl => key.startsWith('url:') ? key.substring(4) : null;

  BuiltInWallpaper? get builtIn {
    if (!key.startsWith('builtin:')) return null;
    final name = key.substring('builtin:'.length);
    for (final wallpaper in BuiltInWallpaper.values) {
      if (wallpaper.name == name) return wallpaper;
    }
    return null;
  }

  @override
  bool operator ==(Object other) => other is ChatWallpaper && other.key == key;

  @override
  int get hashCode => key.hashCode;
}

/// One image from the wallpapers folder in storage.
@immutable
class RemoteWallpaper {
  final String id;
  final String url;

  const RemoteWallpaper({required this.id, required this.url});

  factory RemoteWallpaper.fromJson(Map<String, dynamic> json) =>
      RemoteWallpaper(
        id: json['id'] as String? ?? '',
        url: json['url'] as String? ?? '',
      );

  /// A name for the picker, from the file's: "02-quiet-dunes.jpg" reads as
  /// "Quiet dunes". The leading number is how a curator orders them.
  String get label {
    var name = id;
    final dot = name.lastIndexOf('.');
    if (dot > 0) name = name.substring(0, dot);
    name = name.replaceFirst(RegExp(r'^\d+[-_ ]*'), '');
    name = name.replaceAll(RegExp(r'[-_]+'), ' ').trim();
    if (name.isEmpty) return 'Wallpaper';
    return name[0].toUpperCase() + name.substring(1);
  }
}
