import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 84});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'lib/assets/logo.svg',
      width: size,
      height: size,
    );
  }
}
