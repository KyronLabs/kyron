import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/realtime_client.dart';

void main() {
  group('RealtimeEvent.tryParse', () {
    test('reads an event the server sent', () {
      final event = RealtimeEvent.tryParse(
        '{"type":"message.new","conversationId":"c1","messageId":"m1"}',
      );

      expect(event, isNotNull);
      expect(event!.type, 'message.new');
      expect(event.conversationId, 'c1');
      expect(event.messageId, 'm1');
    });

    test('ignores a frame it cannot read rather than throwing', () {
      // A server that has moved ahead of this client is not a reason to tear
      // the connection down.
      expect(RealtimeEvent.tryParse('not json'), isNull);
      expect(RealtimeEvent.tryParse('[]'), isNull);
      expect(RealtimeEvent.tryParse('{"no":"type"}'), isNull);
      expect(RealtimeEvent.tryParse('{"type":7}'), isNull);
    });

    test('an event with no conversation reads as none, not an error', () {
      final event = RealtimeEvent.tryParse(
        '{"type":"notification.new","kind":"like","actorId":"u2"}',
      );

      expect(event!.conversationId, isNull);
      expect(event.data['kind'], 'like');
    });
  });

  group('RealtimeClient', () {
    test('starts disconnected and stays so until started', () {
      final client = RealtimeClient(baseUrl: 'https://api.example.test');

      expect(client.isConnected, isFalse);
    });

    test('stopping a client that never started is not an error', () async {
      final client = RealtimeClient(baseUrl: 'https://api.example.test');

      await expectLater(client.stop(), completes);
      await client.dispose();
    });
  });
}
