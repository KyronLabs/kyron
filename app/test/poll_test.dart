import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/poll.dart';

Map<String, dynamic> _json({
  bool closed = false,
  String? votedOptionId,
  int totalVotes = 0,
  List<Map<String, dynamic>>? options,
  String? closesAt,
}) =>
    {
      'id': 'poll-1',
      'closesAt': closesAt ??
          DateTime.now().add(const Duration(hours: 2)).toIso8601String(),
      'closed': closed,
      'totalVotes': totalVotes,
      'votedOptionId': votedOptionId,
      'options': options ??
          [
            {'id': 'a', 'text': 'Yes', 'votes': 0},
            {'id': 'b', 'text': 'No', 'votes': 0},
          ],
    };

void main() {
  group('Poll', () {
    test('reads a poll off the wire', () {
      final poll = Poll.fromJson(_json(totalVotes: 3));
      expect(poll.id, 'poll-1');
      expect(poll.options.map((o) => o.text), ['Yes', 'No']);
      expect(poll.totalVotes, 3);
    });

    test('survives a response missing its options', () {
      final poll = Poll.fromJson({'id': 'p', 'closed': true});
      expect(poll.options, isEmpty);
      expect(poll.totalVotes, 0);
    });

    test('you can vote when it is open and you have not', () {
      expect(Poll.fromJson(_json()).canVote, isTrue);
    });

    test('you cannot vote twice', () {
      final poll = Poll.fromJson(_json(votedOptionId: 'a'));
      expect(poll.hasVoted, isTrue);
      expect(poll.canVote, isFalse);
    });

    test('you cannot vote once it has closed', () {
      expect(Poll.fromJson(_json(closed: true)).canVote, isFalse);
    });

    test('takes closed from the server, not from the local clock', () {
      // The server says closed even though this device thinks there is time
      // left. The server wins: every reader has to agree.
      final poll = Poll.fromJson(_json(
        closed: true,
        closesAt: DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      ));
      expect(poll.closed, isTrue);
      expect(poll.remaining, 'Final results');
    });

    test('a share is the option over the total', () {
      final poll = Poll.fromJson(_json(
        totalVotes: 4,
        options: [
          {'id': 'a', 'text': 'Yes', 'votes': 3},
          {'id': 'b', 'text': 'No', 'votes': 1},
        ],
      ));
      expect(poll.options[0].share(poll.totalVotes), 0.75);
      expect(poll.options[1].share(poll.totalVotes), 0.25);
    });

    test('a poll with no votes gives zero rather than dividing by zero', () {
      final poll = Poll.fromJson(_json());
      // NaN here would draw four broken bars on every fresh poll.
      expect(poll.options[0].share(poll.totalVotes), 0);
    });

    test('phrases the time left the way a person would', () {
      String remaining(Duration left) => Poll.fromJson(
            _json(closesAt: DateTime.now().add(left).toIso8601String()),
          ).remaining;

      // Each is a little past the boundary it is testing. The getter
      // truncates -- 2 days 23 hours is "2 days left" -- so a duration sitting
      // exactly on a boundary would fall to the unit below by the time the
      // clock is read a moment later.
      expect(remaining(const Duration(days: 3, minutes: 1)), '3 days left');
      expect(remaining(const Duration(days: 1, minutes: 1)), '1 day left');
      expect(remaining(const Duration(hours: 5, minutes: 1)), '5 hours left');
      expect(remaining(const Duration(hours: 1, minutes: 1)), '1 hour left');
      expect(remaining(const Duration(minutes: 20, seconds: 1)),
          '20 minutes left');
      expect(remaining(const Duration(seconds: 20)), 'Closing now');
    });

    test('a closing time already past reads as final, not as negative time',
        () {
      final poll = Poll.fromJson(_json(
        closesAt:
            DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
      ));
      expect(poll.remaining, 'Final results');
    });
  });
}
