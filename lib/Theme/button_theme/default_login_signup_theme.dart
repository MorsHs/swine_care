import 'package:flutter/material.dart';

class login_signup_theme extends StatelessWidget {
  final Widget child;
  const login_signup_theme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData(),
      child: child,
    );
  }

  ThemeData themeData() {
    return ThemeData(
        filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(7),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
        minimumSize: WidgetStatePropertyAll(Size(300, 43)),
        backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(44, 95, 190, 1)),
      ),
    ));
  }
}
