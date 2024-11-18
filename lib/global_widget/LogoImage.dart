import 'package:flutter/material.dart';

class Logoimage extends StatelessWidget {
  const Logoimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      child: const Image(
        image: AssetImage('assets/Logo/swinecarelogo.png'),
        width: 350,
        height: 300,
      ),
    );
  }
}
