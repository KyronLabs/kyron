// lib/services/realtime_client.dart
import 'dart:async';
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'app_log.dart';

/// Something the server said happened, without being asked.
class RealtimeEvent {
  final String type;
  final Map<String, dynamic> data;

  const RealtimeEvent(this.type, this.data);

  String? get conversationId => data['conversationId'] as String?;
  String? get messageId => data['messageId'] as String?;

  static RealtimeEvent? tryParse(String frame) {
    try {
      final json = jsonDecode(frame);
      if (json is! Map<String, dynamic>) return null;
      final type = json['type'];
      if (type is! String) return null;
      return RealtimeEvent(type, json);
    } catch (_) {
      // A frame this client cannot read is a server that has moved ahead of
      // it, not a reason to tear the connection down.
      return null;
    }
  }
}

/// The socket the app keeps open while somebody is signed in.
///
/// Read-only: it carries what happened, and the app fetches the thing itself
/// through the same endpoints it always has. That keeps one shape of a message
/// rather than two, and means a dropped connection costs freshness and never
/// correctness -- everything still arrives on the next refresh.
class RealtimeClient {
  final String baseUrl;

  RealtimeClient({required this.baseUrl});

  final _events = StreamController<RealtimeEvent>.broadcast();
  Stream<RealtimeEvent> get events => _events.stream;

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _listener;
  Timer? _retry;

  /// Doubles per failed attempt so a server that is down is not hammered by
  /// every phone that has the app open.
  Duration _backoff = const Duration(seconds: 1);
  static const _maxBackoff = Duration(minutes: 2);

  bool _wanted = false;
  bool get isConnected => _channel != null;

  /// Opens the socket, and keeps it open until [stop].
  void start() {
    if (_wanted) return;
    _wanted = true;
    _connect();
  }

  /// Closes it and stops trying. Called on sign-out.
  Future<void> stop() async {
    _wanted = false;
    _retry?.cancel();
    _retry = null;
    await _teardown();
  }

  Future<void> dispose() async {
    await stop();
    await _events.close();
  }

  void _connect() {
    if (!_wanted || _channel != null) return;

    // Read off the live session: the SDK refreshes in the background, and a
    // token cached when the app started is stale by the time a socket
    // reconnects an hour later.
    final token = Supabase.instance.client.auth.currentSession?.accessToken;
    if (token == null || token.isEmpty) {
      // Not signed in yet. Try again rather than giving up for the session.
      _scheduleRetry();
      return;
    }

    final url = _endpointFor(token);
    try {
      final channel = WebSocketChannel.connect(url);
      _channel = channel;
      _listener = channel.stream.listen(
        _onFrame,
        onError: _onClosed,
        onDone: () => _onClosed(null),
        cancelOnError: true,
      );
    } catch (error) {
      AppLog.instance.error('realtime', 'Could not open the socket: $error');
      _channel = null;
      _scheduleRetry();
    }
  }

  /// The socket URL, which is the API's with the scheme swapped.
  Uri _endpointFor(String token) {
    final api = Uri.parse(baseUrl);
    return api.replace(
      scheme: api.scheme == 'https' ? 'wss' : 'ws',
      path: '/realtime',
      queryParameters: {'token': token},
    );
  }

  void _onFrame(dynamic frame) {
    // The first frame proves the connection works, which is the only honest
    // moment to forget how long the last outage was.
    _backoff = const Duration(seconds: 1);
    if (frame is! String) return;
    final event = RealtimeEvent.tryParse(frame);
    if (event != null && !_events.isClosed) _events.add(event);
  }

  void _onClosed(Object? error) {
    _teardown();
    if (_wanted) _scheduleRetry();
  }

  Future<void> _teardown() async {
    final listener = _listener;
    final channel = _channel;
    _listener = null;
    _channel = null;
    await listener?.cancel();
    await channel?.sink.close();
  }

  void _scheduleRetry() {
    if (!_wanted || _retry != null) return;
    _retry = Timer(_backoff, () {
      _retry = null;
      _connect();
    });
    final next = _backoff * 2;
    _backoff = next > _maxBackoff ? _maxBackoff : next;
  }
}
