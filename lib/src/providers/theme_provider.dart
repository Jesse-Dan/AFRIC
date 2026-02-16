import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:wallet/src/config/theme_config.dart';

final currentThemeDataProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);
  ref.watch(themeProvider.notifier);

  if (themeMode == AppThemeMode.dark) {
    return ThemeConfig.darkTheme;
  }

  return ThemeConfig.lightTheme;
});

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>(
  (ref) => ThemeNotifier(),
);

enum AppThemeMode { light, dark, system }

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.dark);

  ThemeData getThemeData(Brightness platformBrightness) {
    switch (state) {
      case AppThemeMode.dark:
        return ThemeConfig.darkTheme;
      case AppThemeMode.light:
        return ThemeConfig.lightTheme;
      case AppThemeMode.system:
        return platformBrightness == Brightness.dark
            ? ThemeConfig.darkTheme
            : ThemeConfig.lightTheme;
    }
  }

  void setTheme(AppThemeMode mode) {
    state = mode;
  }

  void toggleTheme() {
    if (state == AppThemeMode.light) {
      state = AppThemeMode.dark;
    } else if (state == AppThemeMode.dark) {
      state = AppThemeMode.light;
    } else {
      state = AppThemeMode.light;
    }
  }
}
