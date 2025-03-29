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
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Variable to track the selected authentication method
  String _authMethod = 'password'; // Default to 'password', can be 'email'

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: null, // Explicitly disable FAB
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ArgieSizes.spaceBtwSections),

                // Password Fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
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

                            // Authentication Method Selection
                            Text(
                              "Authenticate Using",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'password',
                                  groupValue: _authMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      _authMethod = value!;
                                      _currentPasswordController.clear();
                                      _emailController.clear();
                                    });
                                  },
                                  activeColor: ArgieColors.primary,
                                ),
                                Text(
                                  "Current Password",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: isDarkMode ? Colors.white70 : Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Radio<String>(
                                  value: 'email',
                                  groupValue: _authMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      _authMethod = value!;
                                      _currentPasswordController.clear();
                                      _emailController.clear();
                                    });
                                  },
                                  activeColor: ArgieColors.primary,
                                ),
                                Text(
                                  "Email Address",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: isDarkMode ? Colors.white70 : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Conditional Field: Current Password or Email Address
                            if (_authMethod == 'password')
                              Textfieldcontainer(
                                isHidden: true,
                                label: "Current Password",
                                controller: _currentPasswordController,
                                showVisibilityToggle: true,
                                prefixIcon: Iconsax.lock,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your current password";
                                  }
                                  return null;
                                },
                              )
                            else
                              Textfieldcontainer(
                                isHidden: false,
                                label: "Email Address",
                                controller: _emailController,
                                showVisibilityToggle: false,
                                prefixIcon: Iconsax.sms,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email address";
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                              ),

                            // New Password
                            Textfieldcontainer(
                              isHidden: true,
                              label: "New Password",
                              controller: _newPasswordController,
                              showVisibilityToggle: true,
                              prefixIcon: Iconsax.lock,
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

                            // Confirm New Password
                            Textfieldcontainer(
                              isHidden: true,
                              label: "Confirm New Password",
                              controller: _confirmPasswordController,
                              showVisibilityToggle: true,
                              prefixIcon: Iconsax.lock,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Update Password Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Update password logic (to be implemented with backend)
                        // For email method, you might send a verification code to the email
                        // For password method, verify the current password
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _authMethod == 'password'
                                  ? "Password updated successfully!"
                                  : "Verification code sent to your email. Please verify to proceed.",
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
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