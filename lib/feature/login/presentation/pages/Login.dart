import 'package:flutter/material.dart';
import 'package:swine_care/global_widget/LogoImage.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Logoimage(),
            Textfieldcontainer()
          ],
        ),),
    );
  }
}
