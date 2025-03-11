import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late bool isPressed;

  @override
  void initState() {
    isPressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 40, bottom: 20, top: 10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isPressed = true;
              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  setState(() {
                    isPressed = false;
                  });
                }
              });
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
            "Forgot Password?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isPressed
                  ? ArgieColors.primary
                  : isDarkMode
                  ? ArgieColors.textthird
                  : ArgieColors.textsecondary,
              decoration: isPressed ? TextDecoration.underline : TextDecoration.none,
              decorationColor: isPressed
                  ? ArgieColors.primary
                  : isDarkMode
                  ? ArgieColors.textthird
                  : ArgieColors.textsecondary,
            ),
          ),
        ),
      ),
    );
  }
}