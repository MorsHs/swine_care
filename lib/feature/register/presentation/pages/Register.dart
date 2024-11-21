import 'package:flutter/material.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
import 'package:swine_care/global_widget/LogoImage.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';

import '../widget/redirect_to_login.dart';
import '../widget/register_button.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: login_signup_theme(
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Logoimage(),
                  LoginOrCreateLabel(label: "Create Account"),
                  Textfieldcontainer(
                    isHidden: false,
                    label: "Username",
                  ),
                  Textfieldcontainer(
                    isHidden: false,
                    label: "Email",
                  ),
                  Textfieldcontainer(
                    isHidden: false,
                    label: "Password",
                  ),
                  Textfieldcontainer(
                    isHidden: false,
                    label: "Confirm Password",
                  ),
                  RegisterButton(),
                  RedirectToLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
