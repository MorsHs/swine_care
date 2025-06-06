import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:swine_care/Theme/button_theme/default_login_signup_theme.dart';
import 'package:swine_care/global_widget/LogoImage.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
                // Header Section with Gradient
                Container(
                  padding: EdgeInsets.all(ArgieSizes.paddingDefault),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ArgieColors.primary.withValues(alpha: isDarkMode ? 0.2 : 0.4),
                        isDarkMode ? ArgieColors.dark : Colors.grey.shade100,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const Logoimage(),
                      const SizedBox(height: 20),
                      Text(
                        "Reset Your Password",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? ArgieColors.textthird : ArgieColors.textBold,
                          shadows: [
                            Shadow(
                              color: isDarkMode
                                  ? ArgieColors.primary.withValues(alpha: 0.3)
                                  : ArgieColors.primary.withValues(alpha: 0.2),
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Enter your email to receive a password reset link.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: ArgieSizes.spaceBtwSections),
                    ],
                  ),
                ),
                // Form Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Textfieldcontainer(
                        isHidden: false,
                        label: "Email",
                        // prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: FilledButton(
                          onPressed: () {
                            // Mock reset password action
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Password reset link sent! (Mock)",
                                  style: GoogleFonts.poppins(),
                                ),
                                backgroundColor: ArgieColors.primary,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.all(16),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 2), () {
                              context.go('/login');
                            });
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: ArgieColors.primary,
                            foregroundColor: ArgieColors.textthird,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text("Send Reset Link"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          context.go('/login');
                        },
                        child: Text(
                          "Back to Login",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ArgieColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: ArgieColors.primary,
                          ),
                        ),
                      ),
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