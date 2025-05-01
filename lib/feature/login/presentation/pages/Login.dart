import 'package:flutter/material.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';
import 'package:swine_care/feature/login/presentation/widget/LoginHeader.dart';
import 'package:swine_care/feature/login/presentation/widget/forgot_password.dart';
import 'package:swine_care/feature/login/presentation/widget/login_button.dart';
import 'package:swine_care/feature/login/presentation/widget/redirect_to_signup.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade100,
      body: SafeArea(
        child: login_signup_theme(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header Section
                LoginHeader(isDarkMode: isDarkMode),

                // Form Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoginOrCreateLabel(label: "Login"),
                      Textfieldcontainer(
                        isHidden: false,
                        label: "Email",
                        // prefixIcon: Icons.email_outlined,
                      ),
                      Textfieldcontainer(
                        isHidden: true,
                        label: "Password",
                        showVisibilityToggle: true,
                        // prefixIcon: Icons.lock_outline,
                      ),
                      ForgotPassword(),
                      LoginButton(),
                      RedirectToSignup(),
                      SizedBox(height: ArgieSizes.spaceBtwSections),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
