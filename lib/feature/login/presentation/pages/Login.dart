import 'package:flutter/material.dart';
import 'package:swine_care/feature/login/presentation/widget/forgot_password.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
import 'package:swine_care/global_widget/LogoImage.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Center(
          child: Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Logoimage(),
                  Column(
                    mainAxisSize: MainAxisSize.max,
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
                      ),
                      ForgotPassword()
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
