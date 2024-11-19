import 'package:flutter/material.dart';

class Logoimage extends StatelessWidget {
  const Logoimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Image(
        image: AssetImage('assets/Logo/swinecarelogo.png'),
        width: 350,

      ),
    );
  }
}
