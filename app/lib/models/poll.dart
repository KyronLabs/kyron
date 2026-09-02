// lib/models/poll.dart

/// A poll attached to a post.
///
/// Counts are always present rather than hidden until you vote. Hiding them is
/// a common pattern and the wrong one: it makes a poll something you have to
/// answer in order to read, and nothing stops a client showing them anyway.
class Poll {
  final String id;

  /// When voting closes.
  final DateTime closesAt;

  /// Decided by the server, not by comparing [closesAt] against this device's
  /// clock -- so every reader agrees about whether a poll is still open.
  final bool closed;

  final int totalVotes;

  /// The option this reader picked, or null if they have not voted.
  final String? votedOptionId;

  final List<PollOption> options;

  const Poll({
    required this.id,
    required this.closesAt,
    required this.closed,
    required this.totalVotes,
    required this.options,
    this.votedOptionId,
  });

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        id: json['id'] as String? ?? '',
        closesAt:
            DateTime.tryParse(json['closesAt'] as String? ?? '')?.toLocal() ??
                DateTime.now(),
        closed: json['closed'] == true,
        totalVotes: (json['totalVotes'] as num?)?.toInt() ?? 0,
        votedOptionId: json['votedOptionId'] as String?,
        options: (json['options'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(PollOption.fromJson)
            .toList(),
      );

  bool get hasVoted => votedOptionId != null;

  /// Whether this reader can still cast a vote.
  bool get canVote => !closed && !hasVoted;

  /// How long is left, phrased the way a person would say it.
  String get remaining {
    if (closed) return 'Final results';

    final left = closesAt.difference(DateTime.now());
    if (left.isNegative) return 'Final results';
    if (left.inDays >= 1) {
      return '${left.inDays} day${left.inDays == 1 ? '' : 's'} left';
    }
    if (left.inHours >= 1) {
      return '${left.inHours} hour${left.inHours == 1 ? '' : 's'} left';
    }
    if (left.inMinutes >= 1) {
      return '${left.inMinutes} minute${left.inMinutes == 1 ? '' : 's'} left';
    }
    return 'Closing now';
  }
}

class PollOption {
  final String id;
  final String text;
  final int votes;

  const PollOption({
    required this.id,
    required this.text,
    required this.votes,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
        id: json['id'] as String? ?? '',
        text: json['text'] as String? ?? '',
        votes: (json['votes'] as num?)?.toInt() ?? 0,
      );

  /// This option's share, 0 to 1. Zero total votes gives zero rather than a
  /// division by zero -- a fresh poll draws four empty bars, not four NaNs.
  double share(int total) => total == 0 ? 0 : votes / total;
}
