import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../models/splash_model.dart';
import 'app_button.dart';
import 'dot_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
    required this.model,
    required this.pageIndex,
    required this.pageCount,
    required this.onNext,
    required this.onBack,
    required this.onGetStarted,
  });

  final SplashModel model;
  final int pageIndex;
  final int pageCount;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onGetStarted;

  bool get _isFirstPage => pageIndex == 0;
  bool get _isLastPage => pageIndex == pageCount - 1;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            colorScheme.background,
            Color.alphaBlend(
              model.accentColor.withOpacity(0.06),
              colorScheme.background,
            ),
            colorScheme.background,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Center(child: _IllustrationPanel(model: model)),
              ),
              const SizedBox(height: 12),
              Text(
                model.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                model.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.75),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),
              DotIndicator(activeIndex: pageIndex, count: pageCount),
              const SizedBox(height: 22),
              if (_isFirstPage)
                AppButton(
                  label: AppStrings.next,
                  onPressed: onNext,
                  variant: AppButtonVariant.filled,
                  expanded: true,
                )
              else if (_isLastPage)
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                        label: AppStrings.back,
                        onPressed: onBack,
                        variant: AppButtonVariant.outlined,
                        expanded: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: AppButton(
                        label: AppStrings.getStarted,
                        onPressed: onGetStarted,
                        variant: AppButtonVariant.filled,
                        expanded: true,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AppButton(
                        label: AppStrings.back,
                        onPressed: onBack,
                        variant: AppButtonVariant.outlined,
                        expanded: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: AppStrings.next,
                        onPressed: onNext,
                        variant: AppButtonVariant.filled,
                        expanded: true,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IllustrationPanel extends StatelessWidget {
  const _IllustrationPanel({required this.model});

  final SplashModel model;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 1.02,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: model.gradientColors,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: model.accentColor.withOpacity(0.18),
              blurRadius: 36,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 22,
              right: 22,
              child: _GlowBubble(
                color: colorScheme.onPrimary.withOpacity(0.18),
                size: 56,
              ),
            ),
            Positioned(
              bottom: 28,
              left: 22,
              child: _GlowBubble(
                color: colorScheme.onPrimary.withOpacity(0.14),
                size: 38,
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: colorScheme.onPrimary.withOpacity(0.22),
                        ),
                      ),
                      child: Icon(
                        model.icon,
                        size: 38,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: colorScheme.onPrimary.withOpacity(0.14),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          _MetricRow(
                            label: 'Monthly balance',
                            value: r'$24,560',
                            color: colorScheme.onPrimary,
                          ),
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              minHeight: 10,
                              value: 0.76,
                              backgroundColor: colorScheme.onPrimary
                                  .withOpacity(0.12),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: <Widget>[
                              _MiniStat(
                                label: 'Income',
                                value: r'$18.2k',
                                color: colorScheme.onPrimary,
                              ),
                              const SizedBox(width: 14),
                              _MiniStat(
                                label: 'Expenses',
                                value: r'$7.6k',
                                color: colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          AppStrings.appName,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowBubble extends StatelessWidget {
  const _GlowBubble({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: color.withOpacity(0.84),
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight.withOpacity(0.12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: color.withOpacity(0.8)),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
