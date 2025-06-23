import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
      return FractionallySizedBox(
        widthFactor: 0.8,
        child: login_signup_theme(
          child: FilledButton(
            onPressed: () {
              if (context.mounted) {
                // Delay navigation to avoid race condition
                Future.delayed(const Duration(milliseconds: 100), () {
                  if (context.mounted) {
                    context.go('/login');
                  }
                });
              }
            },
            child:  Text("Get Started",
            style: GoogleFonts.rubik(
                fontWeight: FontWeight.w400
            ),
          ),
          ),
        ),
      );

  }
}
