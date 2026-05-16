import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../models/splash_model.dart';

class SplashData {
  SplashData._();

  static const List<SplashModel> pages = <SplashModel>[
    SplashModel(
      title: AppStrings.onboardingOneTitle,
      subtitle: AppStrings.onboardingOneSubtitle,
      icon: Icons.account_balance_wallet_rounded,
      accentColor: AppColors.primary,
      gradientColors: <Color>[Color(0xFF0F766E), Color(0xFF14B8A6)],
    ),
    SplashModel(
      title: AppStrings.onboardingTwoTitle,
      subtitle: AppStrings.onboardingTwoSubtitle,
      icon: Icons.show_chart_rounded,
      accentColor: AppColors.secondary,
      gradientColors: <Color>[Color(0xFF1D4ED8), Color(0xFF60A5FA)],
    ),
    SplashModel(
      title: AppStrings.onboardingThreeTitle,
      subtitle: AppStrings.onboardingThreeSubtitle,
      icon: Icons.verified_rounded,
      accentColor: AppColors.accent,
      gradientColors: <Color>[Color(0xFF0F766E), Color(0xFF22C55E)],
    ),
  ];
}
