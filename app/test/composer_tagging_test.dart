import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/community.dart';
import 'package:kyron_app/providers/api_client_provider.dart';
import 'package:kyron_app/providers/composer_provider.dart';
import 'package:kyron_app/screens/community_composer_screen.dart';
import 'package:kyron_app/screens/composer_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/fake_drafts.dart';

/// One person on /profile/search, and an empty list everywhere else.
///
/// Only that path: the composer also asks for the topic catalogue and the
/// signed-in account, and answering those with the same people put "Ada
/// Lovelace" on screen as a topic chip too.
class _OnePerson implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode({
      'items': options.path == '/profile/search'
          ? [
              {
                'id': 'u1',
                'name': 'Ada Lovelace',
                'username': 'ada',
                'followers': 3,
                'kyronPoints': 0,
              },
            ]
          : const <Object>[],
    }),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

const _community = Community(id: 'c1', slug: 'gardeners', name: 'Gardeners');

Future<void> _pump(WidgetTester tester) async {
  final api = ApiClient();
  api.dio.interceptors.clear();
  api.dio.httpClientAdapter = _OnePerson();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [apiClientProvider.overrideWithValue(api)],
      child: const MaterialApp(
        home: CommunityComposerScreen(community: _community),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('the tag button opens the picker and writes the handle in', (
    tester,
  ) async {
    // This button used to insert a bare '@' and leave the writer to remember
    // somebody's handle exactly -- which is why nobody could tag anyone.
    await _pump(tester);

    await tester.enterText(find.byType(TextField), 'morning ');
    await tester.pump();

    await tester.tap(find.byTooltip('Tag someone'));
    await tester.pumpAndSettle();

    // The sheet, by something only it draws.
    expect(find.text('Search by name or handle'), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, 'ada');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ada Lovelace'));
    await tester.pumpAndSettle();

    final box = tester.widget<TextField>(find.byType(TextField).first);
    expect(box.controller!.text, 'morning @ada ');
  });

  testWidgets('the box is four lines, not the whole screen', (tester) async {
    // `expands: true` inside an Expanded made the field the entire page, so
    // the tools and the counter sat at the bottom edge, far from the words.
    await _pump(tester);

    final field = tester.widget<TextField>(find.byType(TextField).first);
    expect(field.expands, isFalse);
    expect(field.minLines, 4);

    final height = tester.getSize(find.byType(TextField).first).height;
    final screen = tester.getSize(find.byType(CommunityComposerScreen)).height;
    expect(height, lessThan(screen / 2));
  });

  testWidgets('the main composer tags through the same picker', (tester) async {
    final api = ApiClient();
    api.dio.interceptors.clear();
    api.dio.httpClientAdapter = _OnePerson();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiClientProvider.overrideWithValue(api),
          // In memory: sqflite has no platform to run on under a widget test,
          // and the composer counts drafts the moment it opens.
          draftServiceProvider.overrideWithValue(FakeDrafts()),
        ],
        child: const MaterialApp(home: ComposerScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'morning ');
    await tester.pump();

    await tester.tap(find.byTooltip('Tag someone'));
    await tester.pumpAndSettle();
    expect(find.text('Search by name or handle'), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, 'ada');
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ada Lovelace'));
    await tester.pumpAndSettle();

    final box = tester.widget<TextField>(find.byType(TextField).first);
    expect(box.controller!.text, 'morning @ada ');

    // And the notifier knows, so the post that is sent carries the tag -- the
    // box and the state used to be able to disagree.
    final container = ProviderScope.containerOf(
      tester.element(find.byType(ComposerScreen)),
    );
    expect(container.read(composerProvider).content, 'morning @ada ');
  });
}
