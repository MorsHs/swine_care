import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/feature/forgotpassword/presentation/widgets/SendResetLink.dart';
import 'package:swine_care/feature/forgotpassword/presentation/widgets/TextLabel1.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String? _errorMessage;

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset link sent! Check your email.'),
            backgroundColor: Colors.blueAccent,
          ),
        );
        if (context.mounted) {
          context.go('/login');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'An unexpected error occurred. Please try again.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.white,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: isDarkMode ? ArgieColors.dark : Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  right: -50,
                  top: 350,
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
                  right: 80,
                  top: 400,
                  child: Container(
                    width: 80,
                    height: 80,
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
                  left: -20,
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
                  left: -10,
                  top: 220,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ArgieColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ],
            ),



            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextLabel1(),

                    const SizedBox(height: 30),
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
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ArgieColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const SendResetLink(),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}


