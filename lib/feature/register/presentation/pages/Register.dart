import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';
import 'package:swine_care/data/repositories/AuthRepository.dart';
import 'package:swine_care/feature/register/presentation/widget/RegisterHeader.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';
import 'package:swine_care/feature/register/presentation/widget/redirect_to_login.dart';
import 'package:swine_care/feature/register/presentation/widget/register_button.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();

  void registerUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        Navigator.pop(context);
        showErrorMessage('Passwords do not match');
        return;
      }

      try {
        await _authRepository.registerUser(
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text,
        );
        Navigator.pop(context);
        if (context.mounted) {
          context.go('/homepage');
        }
      } on Exception catch (e) {
        print('Registration Error: ${e.toString()}');
        Navigator.pop(context);
        showErrorMessage(e.toString().split(': ').last);
      }
    } else {
      Navigator.pop(context);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Stack(
              children: [
                // Decorative circles
                Positioned(
                  right: -50,
                  top: -20,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ArgieColors.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: -60,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ArgieColors.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -40,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ArgieColors.secondary.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Positioned(
                  left: -40,
                  top: 60,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ArgieColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: 220,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ArgieColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ],
            ),

            login_signup_theme(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RegisterHeader(isDarkMode: isDarkMode),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const LoginOrCreateLabel(label: "Create Account"),
                            Textfieldcontainer(
                              controller: usernameController,
                              isHidden: false,
                              label: "Username",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a username';
                                }
                                return null;
                              },
                            ),
                            Textfieldcontainer(
                              controller: emailController,
                              isHidden: false,
                              label: "Email",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            Textfieldcontainer(
                              controller: passwordController,
                              isHidden: true,
                              label: "Password",
                              showVisibilityToggle: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            Textfieldcontainer(
                              controller: confirmPasswordController,
                              isHidden: true,
                              label: "Confirm Password",
                              showVisibilityToggle: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            RegisterButton(onPressed: registerUser),
                            const RedirectToLogin(),
                            const SizedBox(height: ArgieSizes.spaceBtwSections),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]

        ),
      ),
    );
  }
}