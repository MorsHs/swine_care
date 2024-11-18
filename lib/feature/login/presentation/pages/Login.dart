import 'package:flutter/material.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginOrCreateLabel(label: "Login"),
                  Textfieldcontainer(
                    isHidden: false,
                    label: "Email",
                  ),
                  Textfieldcontainer(
                    isHidden: true,
                    label: "Password",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
