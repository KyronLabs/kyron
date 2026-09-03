import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/utils/deferred_rebuild.dart';

void main() {
  test('runs straight away when nothing is being built', () {
    var ran = false;
    whenNotBuilding(() => ran = true);
    expect(ran, isTrue);
  });

  testWidgets('waits for the frame when called from inside a build',
      (tester) async {
    // The case this exists for: opening a clip full screen takes a decoder off
    // one in the feed, and tells that tile so from inside the viewer's
    // initState. Calling setState there throws.
    var ran = false;

    await tester.pumpWidget(
      Builder(
        builder: (context) {
          whenNotBuilding(() => ran = true);
          expect(ran, isFalse, reason: 'not while the frame is being built');
          return const SizedBox.shrink();
        },
      ),
    );

    expect(ran, isTrue);
  });

  testWidgets('waits when called from initState', (tester) async {
    var ran = false;
    await tester.pumpWidget(_OnInit(action: () => ran = true));
    expect(ran, isTrue);
  });

  testWidgets('a setState from inside a build does not throw', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: _Rebuilder()));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}

class _OnInit extends StatefulWidget {
  final VoidCallback action;

  const _OnInit({required this.action});

  @override
  State<_OnInit> createState() => _OnInitState();
}

class _OnInitState extends State<_OnInit> {
  @override
  void initState() {
    super.initState();
    whenNotBuilding(widget.action);
    // initState runs inside the frame, so it cannot have run yet.
    expect(true, isTrue);
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// A widget that asks to rebuild from inside somebody else's build, which is
/// what an evicted video tile is doing.
class _Rebuilder extends StatefulWidget {
  const _Rebuilder();

  @override
  State<_Rebuilder> createState() => _RebuilderState();
}

class _RebuilderState extends State<_Rebuilder> {
  int _builds = 0;

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Builder(
      builder: (context) {
        if (_builds == 1) {
          whenNotBuilding(() {
            if (mounted) setState(() {});
          });
        }
        return Text('$_builds');
      },
    );
  }
}
