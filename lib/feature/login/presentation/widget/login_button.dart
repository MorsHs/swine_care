import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: FilledButton(
        onPressed: () {
          context.go('/homepage');
        },
        child: const Text("Login"),
      ),
    );
  }
}
