import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class ThemeManager {
  static const String _darkModeKey = 'dark_mode_enabled';
  static bool _isDarkMode = false;

  static Future<void> init() async {
    _isDarkMode = Settings.getValue<bool>(_darkModeKey, defaultValue: false) ?? false;
  }

  static bool get isDarkMode => _isDarkMode;

  static Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await Settings.setValue(_darkModeKey, value);
    print('Dark Mode Toggled to: $_isDarkMode');
  }

  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: ArgieColors.primary,
      scaffoldBackgroundColor: _isDarkMode ? ArgieColors.dark : ArgieColors.ligth,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: _isDarkMode ? ArgieColors.textthird : ArgieColors.textprimary),
        bodyMedium: TextStyle(color: _isDarkMode ? ArgieColors.textthird : ArgieColors.textsecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _isDarkMode ? ArgieColors.dark : ArgieColors.primarybackground,
        foregroundColor: _isDarkMode ? ArgieColors.textthird : ArgieColors.textprimary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _isDarkMode ? ArgieColors.dark.withValues(alpha: 0.8) : ArgieColors.textthird.withValues(alpha: 0.9),
        selectedItemColor: ArgieColors.primary,
        unselectedItemColor: _isDarkMode ? ArgieColors.textthird : ArgieColors.textsecondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ArgieColors.primary,
          foregroundColor: _isDarkMode ? Colors.white : ArgieColors.textthird,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      cardTheme: CardTheme(
        color: _isDarkMode ? ArgieColors.dark : ArgieColors.ligth,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}