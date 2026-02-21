import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';
import '../providers/composer_provider.dart';
import 'long_press_sheet.dart';

class PrivacySelector {
  static Future<void> show(BuildContext context) async {
    final items = <String, IconData>{
      'Public': Icons.public,
      'Followers': Icons.people,
      'Mutuals': Icons.people_alt,
      'E2EE': Icons.lock,
    };

    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => LongPressSheet(items: items),
    );

    if (result != null && context.mounted) {
      context.read(composerProvider.notifier).setPrivacy(result);
    }
  }

  static Future<void> showDetailed(BuildContext context) async {
    // Show detailed privacy settings
    debugPrint('Show detailed privacy');
  }
}

extension on BuildContext {
  read(Refreshable<ComposerNotifier> notifier) {}
}