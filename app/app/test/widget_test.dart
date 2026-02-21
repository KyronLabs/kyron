import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyron_app/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: const KyronApp(),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
