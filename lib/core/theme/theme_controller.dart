import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_maneger.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    bool result = PreferencesManeger().getBool("theme") ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManeger().setBool("theme", false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManeger().setBool("theme", true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
