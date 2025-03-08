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
    final ColorScheme colorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
    ).copyWith(
      primary: ArgieColors.primary,
      secondary: _isDarkMode ? ArgieColors.textthird : ArgieColors.textsecondary,
      surface: _isDarkMode ? ArgieColors.dark : ArgieColors.ligth,
      onPrimary: _isDarkMode ? ArgieColors.textthird : Colors.black,
      onSurface: _isDarkMode ? ArgieColors.textthird : ArgieColors.textprimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
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
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) => states.contains(WidgetState.disabled)
                ? (_isDarkMode ? ArgieColors.dark : ArgieColors.textsecondary)
                : ArgieColors.primary,
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
              if (states.contains(WidgetState.disabled)) {
                return _isDarkMode ? ArgieColors.textthird : ArgieColors.textsecondary;
              }
              return _isDarkMode ? ArgieColors.textthird : Colors.black; // Use white in dark mode for contrast
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          elevation: WidgetStateProperty.resolveWith<double>(
                (states) => states.contains(WidgetState.disabled) ? 2 : 8,
          ),
          shadowColor: WidgetStateProperty.resolveWith<Color>(
                (states) => states.contains(WidgetState.disabled)
                ? (_isDarkMode ? ArgieColors.dark : ArgieColors.textsecondary).withValues(alpha: 0.3)
                : ArgieColors.primary.withValues(alpha: 0.5),
          ),
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