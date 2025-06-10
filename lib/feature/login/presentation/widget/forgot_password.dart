import 'package:flutter/material.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const ForgotPasswordWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? ArgieColors.textthird : ArgieColors.textsecondary;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 40, bottom: 20, top: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,

            ),
          ),
        ),
      ),
    );
  }
}