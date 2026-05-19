import 'package:flutter/material.dart';

/// Global theme controller to allow runtime theme changes.
/// Use `themeModeController.value = ThemeMode.dark` to switch to dark.
final ValueNotifier<ThemeMode> themeModeController = ValueNotifier(
  ThemeMode.light,
);

void setThemeMode(ThemeMode mode) => themeModeController.value = mode;

void toggleDarkMode(bool enabled) =>
    themeModeController.value = enabled ? ThemeMode.dark : ThemeMode.light;
