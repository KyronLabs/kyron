import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_app/models/gift.dart';
import 'package:kyron_app/models/user.dart';
import 'package:kyron_app/providers/auth_provider.dart';
import 'package:kyron_app/providers/gifts_provider.dart';
import 'package:kyron_app/repositories/gifts_repository.dart';
import 'package:kyron_app/screens/wallet_screen.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

class _Gifts extends Fake implements GiftsRepository {
  final reads = <Completer<GiftWallet>>[];

  @override
  Future<GiftWallet> wallet() {
    final read = Completer<GiftWallet>();
    reads.add(read);
    return read.future;
  }
}

void main() {
  for (final dark in [false, true]) {
    testWidgets('wallet states (dark $dark)', (tester) async {
      final gifts = _Gifts();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentAuthUserProvider.overrideWith(
              (ref) => User(id: 'creator', email: 'creator@example.test'),
            ),
            giftsRepositoryProvider.overrideWithValue(gifts),
          ],
          child: MaterialApp(
            theme: dark ? KyronTheme.darkTheme : KyronTheme.lightTheme,
            home: const WalletScreen(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      gifts.reads.single.completeError(const FormatException());
      await tester.pumpAndSettle();

      expect(find.text('Could not load this list'), findsOneWidget);
      final retry = find.byTooltip('Retry');
      expect(tester.getSize(retry).shortestSide, greaterThanOrEqualTo(44));

      await tester.tap(retry);
      await tester.pump();
      gifts.reads.last.complete(
        const GiftWallet(
          coins: 1234,
          earned: 16,
          withdrawableEarned: 9,
          purchased: 900,
          promotional: 300,
          legacyComplimentary: 34,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1,234 coins'), findsOneWidget);
      expect(find.text('16 coins'), findsOneWidget);
      expect(find.text('9 coins'), findsOneWidget);
      expect(find.text('Purchased coins'), findsOneWidget);
      expect(find.text('900 coins'), findsOneWidget);
      expect(find.text('Reward coins'), findsOneWidget);
      expect(find.text('300 coins'), findsOneWidget);
      expect(find.text('Legacy complimentary coins'), findsOneWidget);
      expect(find.text('34 coins'), findsOneWidget);
      expect(
        find.text(
          'Coins are not automatically replenished. '
          'New coins are awarded through Kyron reward programmes.',
        ),
        findsOneWidget,
      );

      await tester.tap(find.byTooltip('Check again'));
      await tester.pump();
      expect(find.text('1,234 coins'), findsNothing);

      gifts.reads.last.complete(
        const GiftWallet(
          coins: 0,
          earned: 0,
          recoveryNotices: [
            WalletRecoveryNotice(
              id: 'test-adjustment',
              correction: false,
              coins: 25,
              verifiedRefundCoins: 40,
              orderReference: 'test-order',
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('0 coins'), findsNWidgets(3));
      expect(find.text('Purchased coins'), findsNothing);
      expect(gifts.reads, hasLength(3));
      await tester.scrollUntilVisible(
        find.text('Adjustment reference: test-adjustment'),
        140,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('25 coins'), findsOneWidget);
      expect(find.text('Verified refund: 40 coins'), findsOneWidget);
      expect(find.text('Google Play order: test-order'), findsOneWidget);
      expect(find.text('Contact support'), findsOneWidget);
    });
  }

  testWidgets('signed out wallet does not request balances', (tester) async {
    final gifts = _Gifts();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentAuthUserProvider.overrideWith((ref) => null),
          giftsRepositoryProvider.overrideWithValue(gifts),
        ],
        child: const MaterialApp(home: WalletScreen()),
      ),
    );

    expect(find.text('Sign in to Kyron'), findsOneWidget);
    expect(gifts.reads, isEmpty);
  });
}
