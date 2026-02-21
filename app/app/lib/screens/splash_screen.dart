import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../widgets/gradient_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 700)
    );
    _ctrl.forward();
    
    // NO automatic navigation - RootScreen handles navigation
    // This prevents the "unmounted widget" error
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: FadeTransition(
          opacity: _ctrl.drive(CurveTween(curve: Curves.easeOut)),
          child: const AppLogo(size: 84),
        ),
      ),
    );
  }
}