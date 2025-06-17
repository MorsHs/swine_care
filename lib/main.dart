import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/Route/routes.dart';
import 'package:swine_care/colors/ThemeManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swine_care/data/api/Api.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Settings.init(cacheProvider: SharePreferenceCache());
  await ThemeManager.init();
  //await Api().sendImageToRoboflow();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> _isDarkModeNotifier = ValueNotifier<bool>(ThemeManager.isDarkMode);
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _isDarkModeNotifier.value = ThemeManager.isDarkMode;
    // print('App Initialized with Dark Mode: ${ThemeManager.isDarkMode}'); // Debug print
    _router = RouterConfiguration().routes();
  }

  void updateTheme(bool value) {
    // print('Updating Theme to: $value'); // Debug print
    ThemeManager.toggleDarkMode(value).then((_) {
      setState(() {
        _isDarkModeNotifier.value = value;
        // print('Theme Updated to: $value'); // Debug
      });
    });
  }

  @override
  void dispose() {
    _isDarkModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        // print('Building MaterialApp with Theme: $isDarkMode'); // Debug print
        return MaterialApp.router(
          theme: ThemeManager.getTheme(),
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        );
      },
    );
  }
}

// Update the theme without navigation
void updateTheme(BuildContext context, bool value) {
  final state = context.findAncestorStateOfType<_MyAppState>();
  if (state != null) {
    state.updateTheme(value);
  }
}