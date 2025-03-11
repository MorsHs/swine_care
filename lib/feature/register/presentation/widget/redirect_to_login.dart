import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class RedirectToLogin extends StatefulWidget {
  const RedirectToLogin({super.key});

  @override
  State<RedirectToLogin> createState() => _RedirectToLoginState();
}

class _RedirectToLoginState extends State<RedirectToLogin> {
  late bool isPressed;

  @override
  void initState() {
    isPressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? ArgieColors.textthird : ArgieColors.textsecondary,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.go('/login');
              setState(() {
                isPressed = true;
              });
            },
            onLongPressDown: (details) {
              setState(() {
                isPressed = true;
              });
            },
            onLongPressUp: () {
              setState(() {
                isPressed = false;
              });
            },
            onLongPressCancel: () {
              setState(() {
                isPressed = false;
              });
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isPressed
                    ? ArgieColors.primary
                    : isDarkMode
                    ? ArgieColors.textfifth
                    : ArgieColors.primary,
                decoration: isPressed ? TextDecoration.underline : TextDecoration.none,
                decorationColor: isPressed
                    ? ArgieColors.primary
                    : isDarkMode
                    ? ArgieColors.textfifth
                    : ArgieColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}