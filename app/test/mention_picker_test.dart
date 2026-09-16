import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/providers/api_client_provider.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/services/app_log.dart';
import 'package:kyron_app/widgets/mention_picker_sheet.dart';
import 'package:kyron_app/widgets/skeleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Answers /profile/search with whatever the test set, and records every
/// query it was asked. No network, and no Supabase session to read a token
/// off -- the interceptors are dropped for the same reason.
class _CannedApi implements HttpClientAdapter {
  _CannedApi(this.people);

  List<Map<String, Object?>> people;

  /// Every `q` this was asked for, in order. A picker that fires a request per
  /// keystroke is what the debounce exists to stop.
  final List<String> asked = [];

  /// Set to fail the next search.
  int status = 200;

  /// Set to hold the next answer back, so the test can look at what the
  /// picker shows while a search is still in flight.
  Completer<void>? gate;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    asked.add(options.queryParameters['q'] as String? ?? '');
    if (gate != null) await gate!.future;
    return ResponseBody.fromString(
      jsonEncode({'items': people}),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Map<String, Object?> _person(
  String id, {
  String? name,
  String? username,
  int followers = 0,
}) => {
  'id': id,
  'name': name,
  'username': username,
  'followers': followers,
  'kyronPoints': 0,
};

/// Opens the picker and hands back both the adapter behind it and a place the
/// chosen handle lands.
Future<({_CannedApi api, List<String?> chosen})> _open(
  WidgetTester tester, {
  required List<Map<String, Object?>> people,
  String initialQuery = '',
}) async {
  final adapter = _CannedApi(people);
  final api = ApiClient();
  // The real ones read a Supabase session that no widget test has.
  api.dio.interceptors.clear();
  api.dio.httpClientAdapter = adapter;

  final chosen = <String?>[];

  await tester.pumpWidget(
    ProviderScope(
      overrides: [apiClientProvider.overrideWithValue(api)],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () async {
                  chosen.add(
                    await MentionPickerSheet.show(
                      context,
                      initialQuery: initialQuery,
                    ),
                  );
                },
                child: const Text('tag'),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('tag'));
  await tester.pumpAndSettle();
  return (api: adapter, chosen: chosen);
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('asks who, and does not search one letter', (tester) async {
    final opened = await _open(tester, people: []);

    expect(find.text('Who do you want to tag?'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'a');
    await tester.pump(const Duration(seconds: 1));

    // The server refuses a one-character query, so firing it would be a
    // guaranteed 400 shown to somebody mid-sentence.
    expect(opened.api.asked, isEmpty);
    expect(find.text('Who do you want to tag?'), findsOneWidget);
  });

  testWidgets('finds people and writes the one that is tapped back', (
    tester,
  ) async {
    final opened = await _open(
      tester,
      people: [
        _person('u1', name: 'Ada Lovelace', username: 'ada', followers: 1200),
        _person('u2', name: 'Alan Turing', username: 'alan'),
      ],
    );

    await tester.enterText(find.byType(TextField), 'a l');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Ada Lovelace'), findsOneWidget);
    expect(find.textContaining('@ada · 1.2K followers'), findsOneWidget);

    await tester.tap(find.text('Ada Lovelace'));
    await tester.pumpAndSettle();

    // The handle, not the display name: it is what gets written into the post
    // and what resolves back to an account.
    expect(opened.chosen, ['ada']);
  });

  testWidgets('opens on the mention already being typed', (tester) async {
    final opened = await _open(
      tester,
      people: [_person('u1', name: 'Ada', username: 'ada')],
      initialQuery: 'ad',
    );

    // Pre-filled and already searched: the picker was opened from a half-typed
    // @ad, and making somebody retype it would be the same work twice.
    expect(opened.api.asked, ['ad']);
    expect(find.text('Ada'), findsOneWidget);
  });

  testWidgets('debounces rather than firing a request per keystroke', (
    tester,
  ) async {
    final opened = await _open(tester, people: []);

    for (final text in ['ad', 'ada', 'adal']) {
      await tester.enterText(find.byType(TextField), text);
      await tester.pump(const Duration(milliseconds: 60));
    }
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(opened.api.asked, ['adal']);
  });

  testWidgets('offers nobody who has no handle', (tester) async {
    // A mention is written as @handle. Somebody with none would be inserted
    // as text that resolves to nobody.
    final opened = await _open(
      tester,
      people: [
        _person('u1', name: 'No Handle'),
        _person('u2', name: 'Ada', username: 'ada'),
      ],
    );

    await tester.enterText(find.byType(TextField), 'a');
    await tester.enterText(find.byType(TextField), 'ad');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('No Handle'), findsNothing);
    expect(find.text('Ada'), findsOneWidget);
    expect(opened.chosen, isEmpty);
  });

  testWidgets('says so when nobody matches', (tester) async {
    await _open(tester, people: []);

    await tester.enterText(find.byType(TextField), 'zzzz');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Nobody found'), findsOneWidget);
    expect(find.textContaining('"zzzz"'), findsOneWidget);
  });

  testWidgets('shows the shape of a list while it searches', (tester) async {
    final opened = await _open(tester, people: []);
    final held = Completer<void>();
    opened.api.gate = held;

    await tester.enterText(find.byType(TextField), 'ada');
    // Past the debounce, with the answer still held back.
    await tester.pump(const Duration(milliseconds: 300));

    // People rows, not a spinner in the middle of an empty sheet.
    expect(find.byType(SkeletonList), findsOneWidget);

    opened.api.gate = null;
    held.complete();
    await tester.pumpAndSettle();
    expect(find.byType(SkeletonList), findsNothing);
  });

  testWidgets('a failed search says so and offers a retry', (tester) async {
    final opened = await _open(tester, people: []);
    opened.api.status = 500;

    await tester.enterText(find.byType(TextField), 'ada');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Could not search'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);

    opened.api.status = 200;
    opened.api.people = [_person('u1', name: 'Ada', username: 'ada')];
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(find.text('Ada'), findsOneWidget);
    // The API client logs a failed request, and its flush is a timer the
    // framework would otherwise report as still pending.
    await AppLog.instance.flush();
  });
}
