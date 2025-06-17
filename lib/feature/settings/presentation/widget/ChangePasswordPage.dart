import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/global_widget/TextFieldContainer.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          setState(() {
            _errorMessage = 'No user is currently signed in.';
          });
          return;
        }

        // Re authenticate current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPasswordController.text.trim(),
        );
        await user.reauthenticateWithCredential(credential);

        await user.updatePassword(_newPasswordController.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password updated successfully!'),
            backgroundColor: Colors.blueAccent,
          ),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message ?? 'An error occurred. Please try again.';
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
      floatingActionButton: null,
      backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 26),
                    Expanded(
                      child: Text(
                        "Change Password",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ArgieSizes.spaceBtwSections),

                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Update Your Password",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),

                            Textfieldcontainer(
                              isHidden: true,
                              label: "Current Password",
                              controller: _currentPasswordController,
                              showVisibilityToggle: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your current password";
                                }
                                return null;
                              },
                            ),

                            Textfieldcontainer(
                              isHidden: true,
                              label: "New Password",
                              controller: _newPasswordController,
                              showVisibilityToggle: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a new password";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters long";
                                }
                                return null;
                              },
                            ),

                            Textfieldcontainer(
                              isHidden: true,
                              label: "Confirm New Password",
                              controller: _confirmPasswordController,
                              showVisibilityToggle: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your new password";
                                }
                                if (value != _newPasswordController.text) {
                                  return "Passwords do not match";
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _changePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ArgieColors.primary,
                      foregroundColor: ArgieColors.textthird,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Update Password",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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