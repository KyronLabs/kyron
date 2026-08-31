/// A count as a profile or a post shows it.
///
/// Kept short so "12.3K Followers" fits beside two other stats on a phone,
/// rather than pushing "Following" off the row at four figures.
String formatCount(int value) {
  if (value < 0) return '0';
  if (value < 1000) return '$value';
  if (value < 1000000) return '${_trim(value / 1000)}K';
  if (value < 1000000000) return '${_trim(value / 1000000)}M';
  return '${_trim(value / 1000000000)}B';
}

/// One decimal, and none at all when it would be a trailing zero: 1.2K, but
/// 12K rather than 12.0K.
String _trim(double value) {
  final rounded = (value * 10).floor() / 10;
  return rounded == rounded.roundToDouble()
      ? rounded.toStringAsFixed(0)
      : rounded.toStringAsFixed(1);
}
