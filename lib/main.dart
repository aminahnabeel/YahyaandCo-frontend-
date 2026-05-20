import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/starting/language/app_language.dart';
import 'screens/splash_screen/logo_screen.dart';
import 'theme/theme.dart';
import 'theme/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appLanguageController,
      builder: (context, _) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeModeController,
          builder: (context, themeMode, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: appLanguageController.strings.appTitle,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: appLanguageController.locale,
              builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: child ?? const SizedBox.shrink(),
                );
              },
              supportedLocales: const [Locale('en'), Locale('ur', 'PK')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const LogoScreen(),
            );
          },
        );
      },
    );
  }
}
