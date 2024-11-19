import 'package:flutter/material.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';
import 'package:swine_care/feature/login/presentation/widget/forgot_password.dart';
import 'package:swine_care/feature/login/presentation/widget/login_button.dart';
import 'package:swine_care/feature/login/presentation/widget/redirect_to_signup.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
import 'package:swine_care/global_widget/LogoImage.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Logoimage(),
                LoginOrCreateLabel(label: "Login"),
                Textfieldcontainer(
                  isHidden: false,
                  label: "Email",
                ),
                Textfieldcontainer(
                  isHidden: true,
                  label: "Password",
                ),
                ForgotPassword(),
                login_signup_theme(filledButton: LoginButton()),
                RedirectToSignup()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
