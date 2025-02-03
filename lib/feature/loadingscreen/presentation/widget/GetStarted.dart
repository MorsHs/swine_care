import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              context.go('/login');
            },
            child: const Text("Get Started",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      );

  }
}
