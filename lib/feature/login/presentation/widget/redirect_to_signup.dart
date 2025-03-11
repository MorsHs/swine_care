import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class RedirectToSignup extends StatefulWidget {
  const RedirectToSignup({super.key});

  @override
  State<RedirectToSignup> createState() => _RedirectToSignupState();
}

class _RedirectToSignupState extends State<RedirectToSignup> {
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
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? ArgieColors.textthird : ArgieColors.textsecondary,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.go('/signup');
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
              "Sign Up",
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