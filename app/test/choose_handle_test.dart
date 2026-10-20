import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/current_user.dart';
import 'package:kyron_app/models/handle_check.dart';
import 'package:kyron_app/providers/current_user_provider.dart';
import 'package:kyron_app/providers/profile_provider.dart';
import 'package:kyron_app/repositories/current_user_repository.dart';
import 'package:kyron_app/repositories/profile_repository.dart';
import 'package:kyron_app/screens/choose_handle_screen.dart';
import 'package:kyron_app/screens/root_screen.dart';
import 'package:kyron_app/services/api_client.dart';
import 'package:kyron_app/widgets/app_button.dart';

/// Choosing a handle, for the accounts that never got one: every Google
/// sign-up, and email sign-ups that left the box empty or asked for one
/// already taken.

class _Handles extends ProfileRepository {
  _Handles({this.taken = const {}}) : super(ApiClient());

  final Set<String> taken;
  final asked = <String>[];
  final chosen = <String>[];

  @override
  Future<HandleCheck> handleAvailability(String handle) async {
    asked.add(handle);
    return HandleCheck(
      handle: handle,
      available: !taken.contains(handle),
      reason: taken.contains(handle) ? 'taken' : null,
    );
  }

  @override
  Future<String> chooseHandle(String handle) async {
    chosen.add(handle);
    return handle;
  }
}

/// The account, as /profile/me answers -- with a handle once one is chosen.
class _Me extends CurrentUserRepository {
  _Me(this.handles) : super(ApiClient());
  final _Handles handles;

  @override
  Future<CurrentUser> fetchMe({bool force = false}) async => CurrentUser(
        id: 'u1',
        name: 'Yunnieee',
        username: handles.chosen.isEmpty ? null : handles.chosen.last,
        followers: 0,
        following: 0,
        posts: 0,
      );
}

Future<_Handles> _gate(WidgetTester tester,
    {Set<String> taken = const {}}) async {
  final handles = _Handles(taken: taken);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        profileRepositoryProvider.overrideWithValue(handles),
        currentUserRepositoryProvider.overrideWithValue(_Me(handles)),
      ],
      child: const MaterialApp(home: HandleGate(child: Text('the app'))),
    ),
  );
  await tester.pump();
  await tester.pump(ChooseHandleScreen.debounce);
  await tester.pump();
  return handles;
}

AppButton _continue(WidgetTester tester) =>
    tester.widget<AppButton>(find.widgetWithText(AppButton, 'Continue'));

void main() {
  group('a first suggestion', () {
    test('comes from the display name', () {
      expect(ChooseHandleScreen.suggestionFrom('Yunnieee'), 'yunnieee');
      expect(ChooseHandleScreen.suggestionFrom('Ada Lovelace'), 'ada_lovelace');
    });

    test('drops what a handle cannot hold', () {
      expect(ChooseHandleScreen.suggestionFrom('Gremlin!!'), 'gremlin');
      expect(ChooseHandleScreen.suggestionFrom('x' * 40), 'x' * 30);
    });

    test('is nothing rather than something too short to use', () {
      expect(ChooseHandleScreen.suggestionFrom('Å'), '');
      expect(ChooseHandleScreen.suggestionFrom(null), '');
    });
  });

  testWidgets('an account with no handle is asked for one first', (
    tester,
  ) async {
    await _gate(tester);

    expect(find.text('Choose your handle'), findsOneWidget);
    expect(find.text('the app'), findsNothing);
  });

  testWidgets('offers one made from the name, once it is known to be free', (
    tester,
  ) async {
    final handles = await _gate(tester);

    expect(handles.asked, ['yunnieee']);
    expect(find.text('@yunnieee is yours if you want it.'), findsOneWidget);
    expect(_continue(tester).enabled, isTrue);
  });

  testWidgets('says when one is taken, and will not continue with it', (
    tester,
  ) async {
    await _gate(tester, taken: {'yunnieee'});

    expect(find.text('@yunnieee is taken.'), findsOneWidget);
    expect(_continue(tester).enabled, isFalse);
  });

  testWidgets('takes capitals as lowercase and leaves out spaces', (
    tester,
  ) async {
    await _gate(tester);
    await tester.enterText(
      find.byKey(const ValueKey('handle-field')),
      'Yun Nie',
    );
    await tester.pump();

    final field = tester.widget<TextField>(
      find.byKey(const ValueKey('handle-field')),
    );
    expect(field.controller!.text, 'yunnie');
  });

  testWidgets('asks once typing pauses, not on every key', (tester) async {
    final handles = await _gate(tester);
    handles.asked.clear();

    for (final text in ['y', 'yu', 'yun', 'yunn']) {
      await tester.enterText(find.byKey(const ValueKey('handle-field')), text);
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pump(ChooseHandleScreen.debounce);

    expect(handles.asked, ['yunn']);
  });

  testWidgets('opens the app once the handle is chosen', (tester) async {
    final handles = await _gate(tester);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(handles.chosen, ['yunnieee']);
    expect(find.text('the app'), findsOneWidget);
  });
}
