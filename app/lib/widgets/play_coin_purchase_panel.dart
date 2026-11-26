import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../repositories/play_coins_repository.dart';
import '../screens/coin_help_screen.dart';
import 'action_button.dart';
import 'app_sheet.dart';
import 'hairline.dart';

Future<void> openCoinPurchaseSheet(
  BuildContext context, {
  required String userId,
  required String Function(int) coins,
  required VoidCallback onWalletChanged,
}) async {
  await showAppSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => CoinPurchaseSheet(
      child: !kIsWeb && Platform.isAndroid
          ? PlayCoinPurchasePanel(
              userId: userId,
              coins: coins,
              onWalletChanged: onWalletChanged,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpacingTokens.space16,
              ),
              child: Text(AppLocalizations.of(context).ui(
                'ui_wallet_play_unavailable',
                'Coin purchases are unavailable on this device.',
              )),
            ),
    ),
  );
}

class CoinPurchaseSheet extends StatelessWidget {
  const CoinPurchaseSheet({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(SpacingTokens.space20, 0,
            SpacingTokens.space20, SpacingTokens.space20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    strings.ui('ui_wallet_play_buy', 'Buy coins'),
                    style: TextStyle(
                        fontSize: TypographyTokens.fontSize6,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                ActionIconButton(
                  tooltip: strings.ui('ui_coin_help', 'Coin help'),
                  onPressed: () => openCoinHelp(context),
                  icon: Iconsax.message_question_copy,
                  size: kMinInteractiveDimension,
                  outlined: false,
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class PlayCoinPurchasePanel extends ConsumerStatefulWidget {
  const PlayCoinPurchasePanel({
    required this.userId,
    required this.coins,
    required this.onWalletChanged,
    super.key,
  });

  final String userId;
  final String Function(int) coins;
  final VoidCallback onWalletChanged;

  @override
  ConsumerState<PlayCoinPurchasePanel> createState() =>
      _PlayCoinPurchasePanelState();
}

enum _PurchaseMessage {
  unavailable,
  noRegionalPacks,
  pending,
  checking,
  credited,
  finishing,
  retry
}

class _PlayCoinPurchasePanelState extends ConsumerState<PlayCoinPurchasePanel>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final _billing = InAppPurchase.instance;
  final _cancel = CancelToken();
  final _verifying = <String>{};
  final _finished = <String>{};
  late final StreamSubscription<List<PurchaseDetails>> _updates;
  PlayCoinCatalogue? _catalogue;
  List<ProductDetails> _products = const [];
  String? _selectedProductId;
  _PurchaseMessage? _message;
  bool _loading = false;
  bool _checking = false;
  bool _buying = false;
  bool _launching = false;

  @override
  bool get wantKeepAlive => true;

  bool get _currentAccount =>
      mounted && ref.read(currentAuthUserProvider)?.id == widget.userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updates = _billing.purchaseStream.listen(
      (purchases) => unawaited(_handle(purchases)),
      onError: (Object _, StackTrace __) => _show(_PurchaseMessage.retry),
    );
    unawaited(_load());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_updates.cancel());
    _cancel.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _catalogue != null) {
      if (_buying || _launching || _verifying.isNotEmpty) {
        unawaited(_checkPastPurchases());
      } else {
        unawaited(_load());
      }
    }
  }

  void _show(_PurchaseMessage message) {
    if (_currentAccount) setState(() => _message = message);
  }

  Future<void> _load() async {
    if (!_currentAccount || _loading) return;
    setState(() {
      _loading = true;
      _products = const [];
    });
    try {
      final catalogue =
          await ref.read(playCoinsRepositoryProvider).catalogue(_cancel);
      if (!_currentAccount) return;
      if (catalogue == null) {
        setState(() {
          _catalogue = null;
          _products = const [];
          _message = _PurchaseMessage.unavailable;
        });
        return;
      }
      setState(() => _catalogue = catalogue);
      if (!await _billing.isAvailable()) {
        _show(_PurchaseMessage.unavailable);
        return;
      }
      final details = await _billing.queryProductDetails(
        catalogue.coinsByProduct.keys.toSet(),
      );
      if (!_currentAccount) return;
      if (details.error != null) {
        await _checkPastPurchases();
        _show(_PurchaseMessage.retry);
        return;
      }
      final products = details.productDetails
          .where((product) => catalogue.coinsByProduct.containsKey(product.id))
          .toList()
        ..sort((a, b) => catalogue.coinsByProduct[a.id]!
            .compareTo(catalogue.coinsByProduct[b.id]!));
      setState(() {
        _products = products;
        if (!products.any((product) => product.id == _selectedProductId)) {
          _selectedProductId = products.firstOrNull?.id;
        }
        _message = products.isEmpty ? _PurchaseMessage.noRegionalPacks : null;
      });
      await _checkPastPurchases();
    } on Exception {
      _show(_PurchaseMessage.retry);
    } finally {
      if (_currentAccount) setState(() => _loading = false);
    }
  }

  Future<void> _checkPastPurchases() async {
    if (!_currentAccount || _checking || _catalogue == null) return;
    setState(() => _checking = true);
    try {
      final android =
          _billing.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final response = await android.queryPastPurchases();
      await _handle(response.pastPurchases);
      if (response.error != null) {
        _show(_PurchaseMessage.retry);
      } else {
        if (_currentAccount) {
          if (!_launching && response.pastPurchases.isEmpty) {
            setState(() => _buying = false);
          }
          widget.onWalletChanged();
        }
      }
    } on Exception {
      _show(_PurchaseMessage.retry);
    } finally {
      if (_currentAccount) setState(() => _checking = false);
    }
  }

  Future<void> _buy(ProductDetails product) async {
    final catalogue = _catalogue;
    if (!_currentAccount || catalogue == null || _buying || _launching) return;
    setState(() {
      _buying = true;
      _launching = true;
      _message = null;
    });
    try {
      final opened = await _billing.buyConsumable(
        purchaseParam: GooglePlayPurchaseParam(
          productDetails: product,
          applicationUserName: catalogue.accountId,
        ),
        autoConsume: false,
      );
      if (!opened) _show(_PurchaseMessage.retry);
    } on Exception {
      _show(_PurchaseMessage.retry);
    } finally {
      if (_currentAccount) {
        setState(() {
          _launching = false;
          if (_message == _PurchaseMessage.retry) _buying = false;
        });
      }
    }
  }

  Future<void> _handle(List<PurchaseDetails> purchases) async {
    if (!_currentAccount || _catalogue == null) return;
    for (final purchase in purchases) {
      if (!_currentAccount) return;
      if (purchase.status == PurchaseStatus.canceled ||
          purchase.status == PurchaseStatus.error) {
        if (_buying) {
          setState(() {
            _buying = false;
            _message = purchase.status == PurchaseStatus.error
                ? _PurchaseMessage.retry
                : null;
          });
        }
        continue;
      }
      if (purchase is! GooglePlayPurchaseDetails ||
          purchase.billingClientPurchase.obfuscatedAccountId !=
              _catalogue!.accountId) {
        continue;
      }
      if (purchase.status == PurchaseStatus.pending) {
        setState(() {
          _buying = false;
          _message = _PurchaseMessage.pending;
        });
        continue;
      }
      if (purchase.status != PurchaseStatus.purchased &&
          purchase.status != PurchaseStatus.restored) {
        continue;
      }

      final token = purchase.verificationData.serverVerificationData;
      if (token.isEmpty ||
          _finished.contains(token) ||
          !_verifying.add(token)) {
        continue;
      }
      _show(_PurchaseMessage.checking);
      try {
        final consumed = await ref.read(playCoinsRepositoryProvider).verify(
              productId: purchase.productID,
              purchaseToken: token,
              cancelToken: _cancel,
            );
        if (!_currentAccount) return;
        if (consumed) _finished.add(token);
        _show(
            consumed ? _PurchaseMessage.credited : _PurchaseMessage.finishing);
        widget.onWalletChanged();
      } on Exception {
        _show(_PurchaseMessage.retry);
      } finally {
        _verifying.remove(token);
        if (_currentAccount) setState(() => _buying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final strings = AppLocalizations.of(context);
    final message = switch (_message) {
      _PurchaseMessage.unavailable => strings.ui('ui_wallet_play_unavailable',
          'Coin purchases are unavailable on this device.'),
      _PurchaseMessage.noRegionalPacks => strings.ui(
          'ui_wallet_play_no_regional_packs',
          'No coin packs are available for your Google Play storefront right now.'),
      _PurchaseMessage.pending => strings.ui(
          'ui_wallet_play_pending', 'Google Play is waiting for payment.'),
      _PurchaseMessage.checking =>
        strings.ui('ui_wallet_play_checking', 'Checking your purchase…'),
      _PurchaseMessage.credited =>
        strings.ui('ui_wallet_play_credited', 'Your Wallet has been updated.'),
      _PurchaseMessage.finishing => strings.ui('ui_wallet_play_finishing',
          'Coins credited. Check again to finish the purchase.'),
      _PurchaseMessage.retry => strings.ui('ui_wallet_play_retry',
          'Check your purchase again before buying more.'),
      null => null,
    };
    final selected = _products
        .where((product) => product.id == _selectedProductId)
        .firstOrNull;
    final blocked = _buying ||
        _launching ||
        _checking ||
        _loading ||
        _verifying.isNotEmpty ||
        _message == _PurchaseMessage.pending ||
        _message == _PurchaseMessage.finishing ||
        _message == _PurchaseMessage.retry ||
        _message == _PurchaseMessage.unavailable;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_loading && _products.isEmpty)
          const Center(child: CircularProgressIndicator()),
        if (_products.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: SpacingTokens.space12),
            child: Text(
              strings.ui('ui_wallet_play_regional_prices',
                  'Prices and availability come from your Google Play storefront.'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        for (final product in _products) ...[
          const Hairline(),
          CoinPackOption(
            coins: _catalogue!.coinsByProduct[product.id]!,
            label: widget.coins(_catalogue!.coinsByProduct[product.id]!),
            price: product.price,
            selected: product.id == _selectedProductId,
            onTap: blocked
                ? null
                : () => setState(
                      () => _selectedProductId = product.id,
                    ),
          ),
        ],
        if (_products.isNotEmpty) ...[
          const Hairline(),
          const SizedBox(height: SpacingTokens.space16),
          ActionButton(
            label: strings.ui('ui_wallet_recharge', 'Recharge'),
            expand: true,
            onPressed: blocked || selected == null
                ? null
                : () => unawaited(_buy(selected)),
          ),
        ],
        if (message != null)
          Padding(
            padding: const EdgeInsets.all(SpacingTokens.space16),
            child: Semantics(liveRegion: true, child: Text(message)),
          ),
        if ((_buying && !_launching) ||
            _message == _PurchaseMessage.retry ||
            _message == _PurchaseMessage.finishing ||
            _message == _PurchaseMessage.pending ||
            _message == _PurchaseMessage.unavailable ||
            _message == _PurchaseMessage.noRegionalPacks)
          Padding(
            padding: const EdgeInsets.all(SpacingTokens.space16),
            child: ActionButton(
              label: strings.literalcheckAgain,
              kind: ActionButtonKind.outlined,
              onPressed:
                  _checking || _loading ? null : () => unawaited(_load()),
            ),
          ),
      ],
    );
  }
}

class CoinPackOption extends StatelessWidget {
  const CoinPackOption({
    required this.coins,
    required this.label,
    required this.price,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final int coins;
  final String label;
  final String price;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final art = switch (coins) {
      100 => 'assets/gifts/coin_pack_100.png',
      500 => 'assets/gifts/coin_pack_500.png',
      1000 => 'assets/gifts/coin_pack_1000.png',
      _ => 'assets/gifts/coin.png',
    };
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: Ink(
          color: selected ? colors.primary.withValues(alpha: 0.08) : null,
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.space8,
            vertical: SpacingTokens.space8,
          ),
          child: Row(
            children: [
              Image.asset(
                art,
                width: kMinInteractiveDimension,
                height: kMinInteractiveDimension,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
              const SizedBox(width: SpacingTokens.space12),
              Expanded(child: Text(label, style: theme.textTheme.titleMedium)),
              Expanded(
                child: Text(
                  price,
                  textAlign: TextAlign.end,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(width: SpacingTokens.space8),
              Icon(
                selected ? Iconsax.tick_circle_copy : Iconsax.record_copy,
                color: selected ? colors.primary : colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
