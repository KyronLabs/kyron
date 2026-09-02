// lib/services/video_still.dart
import 'dart:io';
import 'dart:ui' as ui;

import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

import 'app_log.dart';

/// A still pulled out of a video, and the shape of the clip it came from.
class VideoStill {
  /// Where the JPEG is on disk.
  final String path;

  /// The frame's dimensions, which are the clip's own -- the still is scaled
  /// but not cropped, and the platform applies the file's rotation before
  /// handing the frame over. Reading them here rather than from the player
  /// gets a portrait clip recorded on a phone right; `VideoPlayerValue.size`
  /// reports the stored frame, which for those is landscape.
  final int width;
  final int height;

  const VideoStill({
    required this.path,
    required this.width,
    required this.height,
  });
}

/// Pulls the opening frame out of a video file.
///
/// Every list that draws a post needs a picture of the clip. Without one the
/// only way to show anything is to open a decoder per clip, and a phone has a
/// hard ceiling on how many can be open at once -- past it the next surface
/// fails and the tile goes black. So the still is made once, on the device
/// that chose the file, and uploaded beside it.
///
/// Returns null rather than throwing when a frame cannot be read: a clip that
/// will not give up a still is still a clip worth posting, and the reader
/// falls back to opening a player for it.
Future<VideoStill?> extractVideoStill(String videoPath) async {
  try {
    final directory = await getTemporaryDirectory();

    final file = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: directory.path,
      imageFormat: ImageFormat.JPEG,
      // Wide enough to fill a phone at full width without being a second
      // upload worth worrying about. Height is scaled to keep the clip's
      // shape; giving both would stretch it.
      maxWidth: 720,
      quality: 80,
      // The very first frame of a clip is often black -- a fade-in, or the
      // camera still opening -- so the still comes from a moment in.
      timeMs: 500,
    );

    final size = await _decodeSize(file.path);
    if (size == null) return null;

    return VideoStill(path: file.path, width: size.$1, height: size.$2);
  } catch (error) {
    AppLog.instance
        .error('media', 'Could not read a still from a clip: $error');
    return null;
  }
}

/// The dimensions of an image on disk, or null when it cannot be decoded.
Future<(int, int)?> _decodeSize(String path) async {
  ui.Codec? codec;
  try {
    final bytes = await File(path).readAsBytes();
    codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final size = (frame.image.width, frame.image.height);
    frame.image.dispose();
    if (size.$1 <= 0 || size.$2 <= 0) return null;
    return size;
  } catch (_) {
    return null;
  } finally {
    codec?.dispose();
  }
}
