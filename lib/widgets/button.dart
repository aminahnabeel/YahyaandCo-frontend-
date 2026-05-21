import 'package:flutter/material.dart';

class RoundedPrimaryButton extends StatelessWidget {
  const RoundedPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.height = 50,
    this.width = 220,
    this.maxWidth,
    this.backgroundColor,
    this.elevation = 0,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final double height;
  final double width;
  final double? maxWidth;
  final Color? backgroundColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final primaryColor = backgroundColor ?? Theme.of(context).colorScheme.primary;

    Widget buttonChild = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shadowColor: Colors.black45,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),

          if (icon != null) ...[
            const SizedBox(width: 8),
            Icon(
              icon,
              size: 18,
            ),
          ],
        ],
      ),
    );

    if (fullWidth) {
      final w = maxWidth ?? double.infinity;
      return Center(child: SizedBox(width: w, height: height, child: buttonChild));
    }

    return Center(child: SizedBox(width: width, height: height, child: buttonChild));
  }
}