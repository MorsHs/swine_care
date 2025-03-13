import 'package:flutter/material.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';
import 'package:swine_care/feature/register/presentation/widget/RegisterHeader.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';
import 'package:swine_care/feature/register/presentation/widget/redirect_to_login.dart';
import 'package:swine_care/feature/register/presentation/widget/register_button.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade100,
      body: SafeArea(
        child: login_signup_theme(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                RegisterHeader(isDarkMode: isDarkMode),

                // Form Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      LoginOrCreateLabel(label: "Create Account"),
                      Textfieldcontainer(
                        isHidden: false,
                        label: "Username",
                        prefixIcon: Icons.person_outline,
                      ),
                      Textfieldcontainer(
                        isHidden: false,
                        label: "Email",
                        prefixIcon: Icons.email_outlined,
                      ),
                      Textfieldcontainer(
                        isHidden: true,
                        label: "Password",
                        showVisibilityToggle: true,
                        prefixIcon: Icons.lock_outline,
                      ),
                      Textfieldcontainer(
                        isHidden: true,
                        label: "Confirm Password",
                        showVisibilityToggle: true,
                        prefixIcon: Icons.lock_outline,
                      ),
                      RegisterButton(),
                      RedirectToLogin(),
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
