import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/conversation.dart';
import 'package:kyron_app/providers/presence_provider.dart';
import 'package:kyron_app/providers/realtime_provider.dart';
import 'package:kyron_app/services/realtime_client.dart';

/// Who has the app open, as the socket says it.
void main() {
  const ada = MessagePerson(id: 'ada', name: 'Ada', online: true);
  const bo = MessagePerson(id: 'bo', name: 'Bo');

  /// Applies an event the way the realtime bridge does, with a real Ref.
  final apply = Provider<void Function(RealtimeEvent)>(
    (ref) => (event) => applyRealtimeEvent(ref, event),
  );

  test('until the socket has spoken, the page stands', () {
    const state = PresenceState();
    expect(state.of(ada), isTrue);
    expect(state.of(bo), isFalse);
  });

  test('a snapshot on connecting replaces what the page said', () {
    // Whatever changed while the socket was gone was never sent to it.
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(apply)(
      const RealtimeEvent('presence.snapshot', {
        'type': 'presence.snapshot',
        'online': ['bo'],
      }),
    );

    final state = container.read(presenceProvider);
    expect(state.of(ada), isFalse, reason: 'not named, so not online');
    expect(state.of(bo), isTrue);
  });

  test('then each change as it happens', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(apply)(
      const RealtimeEvent('presence', {
        'type': 'presence',
        'userId': 'bo',
        'online': true,
      }),
    );
    expect(container.read(presenceProvider).of(bo), isTrue);

    container.read(apply)(
      const RealtimeEvent('presence', {
        'type': 'presence',
        'userId': 'bo',
        'online': false,
      }),
    );
    expect(container.read(presenceProvider).of(bo), isFalse);
  });

  test('a malformed one changes nothing', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(apply)(
      const RealtimeEvent('presence', {'type': 'presence', 'userId': 'bo'}),
    );
    expect(container.read(presenceProvider).live, isFalse);
  });
}
