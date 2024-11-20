import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: FilledButton(
        onPressed: () {},
        child: const Text("Login"),
      ),
    );
  }
}
