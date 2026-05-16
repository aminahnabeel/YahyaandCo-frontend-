import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
  });

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: count,
        effect: ExpandingDotsEffect(
          activeDotColor: colorScheme.primary,
          dotColor: colorScheme.outlineVariant.withOpacity(0.7),
          dotHeight: 10,
          dotWidth: 10,
          expansionFactor: 3.2,
          spacing: 8,
        ),
      ),
    );
  }
}
