// lib/widgets/voice_waveform.dart
import 'package:flutter/material.dart';

/// A recording's loudness drawn as a row of bars, filled up to [progress].
///
/// A painter rather than a Row of Containers: a ten-minute recording is two
/// hundred bars, and two hundred widgets rebuilt on every frame of playback is
/// a dropped frame per post. This repaints only when the values it draws
/// change, and paints them in one pass.
class VoiceWaveform extends StatelessWidget {
  /// Loudness over time, 0-100, one value per bar.
  final List<int> levels;

  /// How far through the recording playback has got, 0 to 1. Bars before it
  /// are filled; bars after it are the track colour.
  final double progress;

  final Color color;
  final Color trackColor;

  const VoiceWaveform({
    super.key,
    required this.levels,
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  /// The most bars a recording carries.
  ///
  /// Two hundred is about what fits across a phone at a legible width, and is
  /// what the recorder downsamples to once a recording runs long enough to
  /// produce more.
  static const int maxBars = 200;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WaveformPainter(
        levels: levels,
        progress: progress.clamp(0.0, 1.0),
        color: color,
        trackColor: trackColor,
      ),
      // Expands to whatever it is given; the caller decides the height.
      child: const SizedBox.expand(),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final List<int> levels;
  final double progress;
  final Color color;
  final Color trackColor;

  const _WaveformPainter({
    required this.levels,
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (levels.isEmpty || size.width <= 0) return;

    // Bars are drawn at a fixed width and spacing, and only as many as fit --
    // stretching forty bars across a full-width row turns a short recording
    // into a picket fence.
    const barWidth = 2.5;
    const gap = 2.0;
    final slot = barWidth + gap;

    final fits = (size.width / slot).floor().clamp(1, levels.length);
    final step = levels.length / fits;

    final filled = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barWidth;
    final track = Paint()
      ..color = trackColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barWidth;

    final middle = size.height / 2;
    final playedUpTo = fits * progress;

    for (var i = 0; i < fits; i++) {
      // Each drawn bar is the loudest sample it stands for, not the first --
      // taking the first drops every peak that falls between two slots and
      // flattens the whole waveform.
      var level = 0;
      final from = (i * step).floor();
      final to = ((i + 1) * step).ceil().clamp(0, levels.length);
      for (var j = from; j < to; j++) {
        if (levels[j] > level) level = levels[j];
      }

      // A floor of two pixels, so silence is a dot on the line rather than a
      // gap that reads as the recording having stopped.
      final height = (level / 100 * (size.height - 4)).clamp(2.0, size.height);
      final x = i * slot + barWidth / 2;

      canvas.drawLine(
        Offset(x, middle - height / 2),
        Offset(x, middle + height / 2),
        i < playedUpTo ? filled : track,
      );
    }
  }

  @override
  bool shouldRepaint(_WaveformPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.trackColor != trackColor ||
      old.levels.length != levels.length;
}
