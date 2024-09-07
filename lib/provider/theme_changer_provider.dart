import 'package:flutter/material.dart';

class ThemeChangerProvider with ChangeNotifier {
  dynamic _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
