import 'package:flutter/material.dart';

class RoundedPrimaryButton extends StatelessWidget {
  const RoundedPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = true,
    this.height = 52,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool fullWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final buttonChild = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: Size(0, height),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: height * 0.34, fontWeight: FontWeight.w600)),
          if (icon != null) ...[
            const SizedBox(width: 12),
            Icon(icon, size: 18),
          ],
        ],
      ),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: buttonChild);
    }

    return Center(child: SizedBox(width: 200, child: buttonChild));
  }
}
