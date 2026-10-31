import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/utils/display_url.dart';
import 'package:kyron_app/widgets/post_text.dart';

/// A long link is shown short and opened whole.
void main() {
  const newScientist =
      'https://www.newscientist.com/article/2595718-this-weeks-new-questions-369/'
      '?utm_term=Autofeed&utm_medium=SOC&utm_source=Threads'
      '&utm_id=97760_v0_s00_e0_tv4#Echobox=1793426869';

  group('displayUrl', () {
    test('cuts a long share link to one readable line', () {
      final shown = displayUrl(newScientist);
      expect(shown, startsWith('newscientist.com/article/2595718-'));
      expect(shown, endsWith('…'));
      expect(shown.runes.length, 40);
      expect(shown, isNot(contains('utm_')));
    });

    test('leaves a short link whole, without the scheme or www', () {
      expect(displayUrl('https://example.com'), 'example.com');
      expect(displayUrl('https://www.example.com/'), 'example.com');
      expect(displayUrl('http://example.com/a/b'), 'example.com/a/b');
    });

    test('drops tracking and the fragment, nothing else', () {
      expect(
        displayUrl('https://example.com/story?utm_source=x&fbclid=y#top'),
        'example.com/story',
      );
      expect(
        displayUrl('https://example.com/find?q=cats&utm_medium=SOC'),
        'example.com/find?q=cats',
      );
      // Short names that mean something somewhere stay.
      expect(
        displayUrl('https://youtu.be/abc?t=42'),
        'youtu.be/abc?t=42',
      );
    });

    test('keeps a query that is all there is to tell links apart', () {
      expect(
        displayUrl('https://youtube.com/watch?v=dQw4w9WgXcQ'),
        'youtube.com/watch?v=dQw4w9WgXcQ',
      );
      expect(displayUrl('https://example.com/?id=42'), 'example.com/?id=42');
    });

    test('never splits a character in half', () {
      final shown =
          displayUrl('https://example.com/${'é' * 30}🙂🙂🙂', max: 32);
      expect(shown.runes.length, 32);
      expect(shown, endsWith('…'));
    });
  });

  group('a link in a post', () {
    Future<void> pump(WidgetTester tester, String content) => tester.pumpWidget(
          MaterialApp(home: Scaffold(body: PostText(content: content))),
        );

    String drawn(WidgetTester tester) =>
        tester.widget<RichText>(find.byType(RichText).first).text.toPlainText();

    testWidgets('is drawn short, with the rest of the post as written', (
      tester,
    ) async {
      await pump(tester, 'Good questions this week $newScientist');

      final text = drawn(tester);
      expect(text, startsWith('Good questions this week newscientist.com/'));
      expect(text, endsWith('…'));
      expect(text, isNot(contains('utm_')));
      expect(text, isNot(contains('https://')));
    });

    testWidgets('leaves the sentence its full stop', (tester) async {
      await pump(tester, 'Read https://example.com/page.');
      expect(drawn(tester), 'Read example.com/page.');
    });
  });
}
