import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  const GradientScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: isDark
          ? body
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.lightBackgroundStart,
                    AppTheme.lightBackgroundEnd,
                  ],
                ),
              ),
              child: SafeArea(child: body),
            ),
    );
  }
}
