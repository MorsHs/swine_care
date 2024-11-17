import 'package:flutter/material.dart';

class Logoimage extends StatelessWidget {
  const Logoimage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(flex: 1,
        child: Image(
      image: AssetImage('assets/Logo/swinecarelogo.png'),
      width: 350,
    ));
  }
}
