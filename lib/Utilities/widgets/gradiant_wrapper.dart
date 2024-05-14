import 'package:flutter/material.dart';

class PrimaryGradiantWidget extends StatelessWidget {
  final Widget child;

  const PrimaryGradiantWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFF935FA2),
            Color(0xFFE52E42),
            Color(0xFFF5A334),
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
