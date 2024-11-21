import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: FilledButton(
          onPressed: () {},
          child: const Text("Sign up"),
        ),
      ),
    );
  }
}
