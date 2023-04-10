import 'package:flutter/material.dart';

class LogoComponent extends StatelessWidget {
  final double? size;
  const LogoComponent({super.key, this.size = 14});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.asset(
        'assets/logo.png',
        width: size,
        height: size,
      ),
    );
  }
}
