import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/widgets/create_post/url_preview.dart';
import 'package:kyron_app/widgets/post_text.dart';

/// The spans of [content] that were drawn as something to tap.
Future<List<String>> _links(WidgetTester tester, String content) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: PostText(content: content, selectable: false)),
    ),
  );
  final rich = tester.widget<RichText>(find.byType(RichText).first);
  final out = <String>[];
  rich.text.visitChildren((span) {
    if (span is TextSpan && span.recognizer is TapGestureRecognizer) {
      out.add(span.text!);
    }
    return true;
  });
  return out;
}

void main() {
  testWidgets('a list of bare links is a list of links', (tester) async {
    // The post that found the bug.
    final links = await _links(tester, '''
Free resources to learn Linux & DevOps

Linux → sysxplore.com
AWS → explore.skillbuilder.aws
DevOps → edx.org/learn/devops
Kubernetes → kubernetes.io.''');

    expect(links, [
      'sysxplore.com',
      'explore.skillbuilder.aws',
      'edx.org/learn/devops',
      // The sentence's full stop stays the sentence's.
      'kubernetes.io',
    ]);
  });

  testWidgets('files and abbreviations stay words', (tester) async {
    final links = await _links(
      tester,
      'Built with Node.js, see README.md and run setup.sh, e.g. at 9 a.m.',
    );
    expect(links, isEmpty);
  });

  testWidgets('an address with its scheme still works as before', (
    tester,
  ) async {
    final links = await _links(tester, 'Read https://kyron.so/about now');
    expect(links, ['kyron.so/about']);
  });

  test('the preview takes the first real link, not a file name', () {
    expect(firstLinkIn('see notes.txt then kubernetes.io'),
        'https://kubernetes.io');
    expect(firstLinkIn('Node.js and README.md'), isNull);
    expect(isLinkableHost('learn.microsoft.com'), isTrue);
    expect(isLinkableHost('bbc.co.uk'), isTrue);
    expect(isLinkableHost('script.py'), isFalse);
  });
}
