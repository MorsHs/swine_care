import 'package:flutter/material.dart';

class Logoimage extends StatelessWidget {
  const Logoimage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/Logo/logoswinecare.png'),
      width: 300,

    );
  }
}
