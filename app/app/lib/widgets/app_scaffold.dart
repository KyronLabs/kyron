import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry? padding;

  const AppScaffold({super.key, this.child, this.appBar, this.bottomNavigationBar, this.padding});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
