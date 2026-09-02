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

  /// How long the fill takes to catch up with a new [progress].
  ///
  /// A player reports its position a few times a second, so drawing each
  /// reading the moment it lands makes the fill jump forward in visible steps.
  /// Sweeping to it over about the gap between readings turns those steps back
  /// into movement. Zero draws each reading as it arrives.
  final Duration smoothing;

  const VoiceWaveform({
    super.key,
    required this.levels,
    required this.progress,
    required this.color,
    required this.trackColor,
    this.smoothing = const Duration(milliseconds: 260),
  });

  /// The most bars a recording carries.
  ///
  /// Two hundred is about what fits across a phone at a legible width, and is
  /// what the recorder downsamples to on its way out.
  static const int maxBars = 200;

  /// How wide one bar is drawn, and the gap after it.
  static const double barWidth = 2.5;
  static const double barGap = 2.0;
  static const double slot = barWidth + barGap;

  /// Folds a full-resolution set of readings down to [bars] of them.
  ///
  /// Each bar is the loudest reading it stands for. Taking the first instead
  /// would drop every peak falling between two bars and flatten the whole
  /// waveform into a hedge. Shorter input is returned as it is: a five-second
  /// recording is fifty readings and stretching them to two hundred invents
  /// detail that was never recorded.
  static List<int> downsample(List<int> values, int bars) {
    if (bars <= 0) return const [];
    if (values.length <= bars) return List<int>.unmodifiable(values);

    final step = values.length / bars;
    final out = <int>[];
    for (var i = 0; i < bars; i++) {
      var peak = 0;
      final from = (i * step).floor();
      final to = ((i + 1) * step).ceil().clamp(0, values.length);
      for (var j = from; j < to; j++) {
        if (values[j] > peak) peak = values[j];
      }
      out.add(peak);
    }
    return List<int>.unmodifiable(out);
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: progress.clamp(0.0, 1.0)),
      duration: smoothing,
      // Linear, because playback is linear. Anything eased makes the fill
      // hesitate at each reading, which is the thing being fixed.
      curve: Curves.linear,
      builder: (context, value, _) => CustomPaint(
        painter: _WaveformPainter(
          levels: levels,
          progress: value,
          color: color,
          trackColor: trackColor,
        ),
        // Expands to whatever it is given; the caller decides the height.
        child: const SizedBox.expand(),
      ),
    );
  }
}

/// The waveform of a recording still being made, scrolling as it is spoken.
///
/// Bars arrive at the right and travel left, one slot per sample. The travel
/// is drawn against the clock rather than against the samples, so the row
/// moves every frame instead of jumping a whole bar ten times a second --
/// which is what made the recorder look like it was stuttering.
class LiveWaveform extends StatefulWidget {
  /// Loudness over time so far, 0-100. Appended to as the recording runs.
  final List<int> levels;

  /// How often a value is appended. The scroll covers exactly one bar in this
  /// long, so a new bar lands as the row finishes moving over for it.
  final Duration sampleEvery;

  final Color color;

  const LiveWaveform({
    super.key,
    required this.levels,
    required this.sampleEvery,
    required this.color,
  });

  @override
  State<LiveWaveform> createState() => _LiveWaveformState();
}

class _LiveWaveformState extends State<LiveWaveform>
    with SingleTickerProviderStateMixin {
  /// Drives a repaint every frame. Its value is not used -- the painter reads
  /// the clock -- so the duration only sets how often it loops.
  late final AnimationController _frames = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  /// When the newest bar arrived, which is what the scroll is measured from.
  DateTime _advancedAt = DateTime.now();
  int _seen = 0;

  @override
  void initState() {
    super.initState();
    _seen = widget.levels.length;
  }

  @override
  void didUpdateWidget(LiveWaveform old) {
    super.didUpdateWidget(old);
    if (widget.levels.length != _seen) {
      _seen = widget.levels.length;
      _advancedAt = DateTime.now();
    }
  }

  @override
  void dispose() {
    _frames.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LivePainter(
        levels: widget.levels,
        advancedAt: _advancedAt,
        sampleEvery: widget.sampleEvery,
        color: widget.color,
        repaint: _frames,
      ),
      child: const SizedBox.expand(),
    );
  }
}

/// How tall a bar is drawn for a level, given the space available.
double _barHeight(int level, double height) =>
    // A floor of two pixels, so silence is a dot on the line rather than a gap
    // that reads as the recording having stopped.
    (level / 100 * (height - 4)).clamp(2.0, height);

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
    const slot = VoiceWaveform.slot;

    final fits = (size.width / slot).floor().clamp(1, levels.length);
    final step = levels.length / fits;

    final filled = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = VoiceWaveform.barWidth;
    final track = Paint()
      ..color = trackColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = VoiceWaveform.barWidth;

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

      final height = _barHeight(level, size.height);
      final x = i * slot + VoiceWaveform.barWidth / 2;

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

class _LivePainter extends CustomPainter {
  final List<int> levels;
  final DateTime advancedAt;
  final Duration sampleEvery;
  final Color color;

  _LivePainter({
    required this.levels,
    required this.advancedAt,
    required this.sampleEvery,
    required this.color,
    required Listenable repaint,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    if (levels.isEmpty || size.width <= 0) return;

    const slot = VoiceWaveform.slot;

    // How far through the gap between the last sample and the next one we are.
    // This is what turns ten steps a second into continuous movement: the row
    // slides a fraction of a bar every frame and a new bar arrives exactly as
    // the slide completes.
    final elapsed = DateTime.now().difference(advancedAt).inMicroseconds;
    final interval = sampleEvery.inMicroseconds;
    final phase = interval <= 0 ? 0.0 : (elapsed / interval).clamp(0.0, 1.0);

    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = VoiceWaveform.barWidth;

    final middle = size.height / 2;
    // Clipped so the newest bar slides in from the edge rather than appearing
    // outside the box.
    canvas.clipRect(Offset.zero & size);

    // Newest first, walking backwards until the row runs off the left edge.
    final visible = (size.width / slot).ceil() + 2;
    for (var i = 0; i < visible; i++) {
      final index = levels.length - 1 - i;
      if (index < 0) break;

      final x = size.width - (i + phase) * slot - VoiceWaveform.barWidth / 2;
      if (x < -VoiceWaveform.barWidth) break;

      final height = _barHeight(levels[index], size.height);
      canvas.drawLine(
        Offset(x, middle - height / 2),
        Offset(x, middle + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_LivePainter old) => true;
}
