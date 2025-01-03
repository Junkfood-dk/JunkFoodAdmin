import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

class GradiantButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const GradiantButton(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed == null ? 0.3 : 1,
      child: GradientElevatedButton(
        onPressed: onPressed,
        style: GradientElevatedButton.styleFrom(
          backgroundGradient: const LinearGradient(
            colors: [
              Color(0xFF935FA2),
              Color(0xFFE52E42),
              Color(0xFFF5A334),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: child,
      ),
    );
  }
}
