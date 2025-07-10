import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';
import 'package:swine_care/feature/forgotpassword/presentation/pages/ForgotPassword.dart';
import 'package:swine_care/feature/login/presentation/widget/LoginHeader.dart';
import 'package:swine_care/feature/login/presentation/widget/forgot_password.dart';
import 'package:swine_care/feature/login/presentation/widget/login_button.dart';
import 'package:swine_care/feature/login/presentation/widget/redirect_to_signup.dart';
import 'package:swine_care/global_widget/Login_or_create_label.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/data/repositories/AuthRepository.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();

  void signUserIn() async {
    // ADMIN SHORTCUT
    if (emailController.text.toLowerCase() == 'controlpanel' &&
        passwordController.text == 'admin123') {
      print('ADMIN SHORTCUT TRIGGERED');
      if (context.mounted) {
        context.go('/admin/control-panel');
      }
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    if (_formKey.currentState!.validate()) {
      try {
        await _authRepository.loginUser(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
        if (context.mounted) {
          context.go('/homepage');
        }
      } on Exception catch (e) {
        Navigator.pop(context);
        final errorMessage = e.toString().replaceFirst('Login failed: ', ' ');
        showErrorMessage(errorMessage);
      }
    } else {
      Navigator.pop(context);
    }
  }

  void showErrorMessage(String message) {
    String displayMessage;
    switch (message) {
      case 'user-not-found':
        displayMessage = 'No user found with that email.';
        break;
      case 'wrong-password':
        displayMessage = 'Incorrect password. Please try again.';
        break;
      case 'invalid-email':
        displayMessage = 'The email address is invalid.';
        break;
      case 'too-many-requests':
        displayMessage = 'Too many attempts. Please try again later.';
        break;
      default:
        displayMessage = 'Invalid email or password. Please try again.';
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(displayMessage),
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
                  left: 40,
                  top: 20,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ArgieColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: 200,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LoginHeader(isDarkMode: isDarkMode),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const LoginOrCreateLabel(label: "Login"),
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
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),

                            ForgotPasswordWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ForgotPassword()),
                                );
                              },
                            ),
                            LoginButton(onPressed: signUserIn),
                            const RedirectToSignup(),
                            const SizedBox(height: ArgieSizes.spaceBtwSections),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}