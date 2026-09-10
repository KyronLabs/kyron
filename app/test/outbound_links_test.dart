import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/services/app_browser.dart';

/// Kyron used to leave for a page in twelve places, on twelve opinions about
/// whether a link deserved the app's own browser. Two of them sent every link
/// in a post to Chrome. These are the tests that stop that coming back: the
/// rule is not "the current code happens to route links properly", it is "only
/// one file in the app can leave at all".
void main() {
  group('one door out of the app', () {
    /// The file allowed to hand a link to another app.
    const door = 'lib/services/app_browser.dart';

    late List<File> sources;

    setUpAll(() {
      sources = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .toList();
      // A search that finds nothing passes every assertion below, so prove it
      // is looking at the app before trusting what it says about the app.
      expect(sources.length, greaterThan(50));
    });

    test('only app_browser.dart imports url_launcher', () {
      final importers = sources
          .where((file) => file.readAsStringSync().contains('url_launcher'))
          .map((file) => file.path.replaceAll(r'\', '/'))
          .toList();

      expect(importers, [door]);
    });

    test('only app_browser.dart calls launchUrl', () {
      final callers = <String>[];
      for (final file in sources) {
        if (!file.readAsStringSync().contains('launchUrl(')) continue;
        callers.add(file.path.replaceAll(r'\', '/'));
      }

      expect(callers, [door]);
    });

    test('and only app_browser.dart opens the browser', () {
      // The same rule one level in. Two call sites meant two policies, and
      // the second one sent every link in a post to Chrome; a browser two
      // files can open is a browser two files can decide about.
      final openers = <String>[];
      for (final file in sources) {
        final text = file.readAsStringSync();
        if (!text.contains('BrowserRoute')) continue;
        openers.add(file.path.replaceAll(r'\', '/'));
      }

      expect(
        openers..sort(),
        ['lib/screens/browser/browser_route.dart', door],
      );
    });

    test('and that file really does hold the call, so this can fail', () {
      // Without this, deleting the launch entirely would turn both tests above
      // green while breaking every mailto: link in the app.
      final door = File('lib/services/app_browser.dart').readAsStringSync();
      expect(door, contains('launchUrl('));
      expect(door, contains('LaunchMode.externalApplication'));
      expect(door, contains('BrowserRoute.open('));
    });
  });

  group('AppBrowser.parse', () {
    test('reads a bare domain as a link, the way a post means it', () {
      expect(
          AppBrowser.parse('example.com')?.toString(), 'https://example.com');
      expect(AppBrowser.parse('sub.example.co.uk/a/b')?.toString(),
          'https://sub.example.co.uk/a/b');
    });

    test('leaves a URL that names its own scheme alone', () {
      expect(AppBrowser.parse('http://example.com')?.scheme, 'http');
      expect(AppBrowser.parse('mailto:hi@example.com')?.scheme, 'mailto');
      expect(AppBrowser.parse('tel:+441234567890')?.scheme, 'tel');
    });

    test('trims, because a link pulled out of text carries whitespace', () {
      expect(AppBrowser.parse('  example.com  ')?.host, 'example.com');
    });

    test('refuses what is not a link', () {
      expect(AppBrowser.parse(''), isNull);
      expect(AppBrowser.parse('   '), isNull);
      expect(AppBrowser.parse('https://'), isNull);
    });
  });

  group('AppBrowser.destinationOf', () {
    test('http and https stay inside Kyron', () {
      expect(AppBrowser.destinationOf(Uri.parse('https://example.com')),
          LinkDestination.inApp);
      expect(AppBrowser.destinationOf(Uri.parse('http://example.com')),
          LinkDestination.inApp);
    });

    test('a scheme no web view renders is handed to the device', () {
      for (final raw in [
        'mailto:hi@example.com',
        'tel:+441234567890',
        'sms:+441234567890',
        'geo:51.5,-0.12',
      ]) {
        expect(
            AppBrowser.destinationOf(Uri.parse(raw)), LinkDestination.handOff,
            reason: raw);
      }
    });

    test('a web URL with no host is refused rather than opened', () {
      // Uri.parse('https:///x') has scheme and no host. Loading it shows an
      // error page for something that was never a page.
      expect(AppBrowser.destinationOf(Uri.parse('https:///x')),
          LinkDestination.refused);
    });
  });
}
