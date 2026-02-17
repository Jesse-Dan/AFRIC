import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:wallet/src/config/theme_config.dart';
import 'package:wallet/src/reusables/utils/storage_util.dart';

final currentThemeDataProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);

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
  static const String _themeKey = 'app_theme_mode';

  ThemeNotifier() : super(AppThemeMode.dark) {
    _loadThemeFromStorage();
  }

  Future<void> _loadThemeFromStorage() async {
    try {
      final savedTheme = await StorageUtil.instance.get<String>(_themeKey);

      if (savedTheme != null) {
        final themeMode = _stringToThemeMode(savedTheme);
        state = themeMode;
      }
    } catch (e) {
      debugPrint('[ThemeNotifier] Error loading theme: $e');
    }
  }

  Future<void> _saveThemeToStorage(AppThemeMode mode) async {
    try {
      final themeString = _themeModeToString(mode);
      await StorageUtil.instance.save(_themeKey, themeString);
      debugPrint('[ThemeNotifier] Theme saved: $themeString');
    } catch (e) {
      debugPrint('[ThemeNotifier] Error saving theme: $e');
    }
  }

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
    _saveThemeToStorage(mode);
  }

  void toggleTheme() {
    if (state == AppThemeMode.light) {
      state = AppThemeMode.dark;
    } else if (state == AppThemeMode.dark) {
      state = AppThemeMode.light;
    } else {
      state = AppThemeMode.light;
    }
    _saveThemeToStorage(state);
  }

  String _themeModeToString(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }

  AppThemeMode _stringToThemeMode(String value) {
    switch (value.toLowerCase()) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
        return AppThemeMode.system;
      default:
        return AppThemeMode.dark;
    }
  }
}
