import 'package:flutter/material.dart';

class HoverableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool selected;
  final Color? selectedBackground;
  final Color? selectedBorderColor;
  final double selectedBorderWidth;

  const HoverableCard({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadius = 14,
    this.selected = false,
    this.selectedBackground,
    this.selectedBorderColor,
    this.selectedBorderWidth = 2.0,
  }) : super(key: key);

  @override
  State<HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard> {
  bool _hover = false;

  void _setHover(bool v) => setState(() => _hover = v);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: _hover
            ? (Matrix4.identity()..scale(1.01))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: widget.selected
              ? (widget.selectedBackground ??
                    cs.primary.withValues(alpha: 0.08))
              : (_hover ? cs.primary.withValues(alpha: 0.06) : cs.surface),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: widget.selected
                ? (widget.selectedBorderColor ?? cs.primary)
                : (_hover ? cs.primary : cs.outline.withValues(alpha: 0.6)),
            width: widget.selected
                ? widget.selectedBorderWidth
                : (_hover ? 2.0 : 1.0),
          ),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: _hover ? 0.12 : 0.03),
              blurRadius: _hover ? 18 : 8,
              offset: Offset(0, _hover ? 8 : 3),
            ),
            if (_hover)
              BoxShadow(
                color: cs.primary.withValues(alpha: 0.12),
                blurRadius: 28,
                spreadRadius: 1.5,
                offset: const Offset(0, 0),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
