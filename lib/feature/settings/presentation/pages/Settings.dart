import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/feature/settings/presentation/widget/SectionHeading.dart';
import 'package:swine_care/feature/settings/presentation/widget/SettingMenuTile.dart';
import 'package:swine_care/feature/settings/presentation/widget/UserProfileInfoContent.dart';
import 'package:swine_care/colors/ThemeManager.dart';
import 'package:swine_care/main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    isDarkModeEnabled = ThemeManager.isDarkMode;
    print('Initial Dark Mode State: $isDarkModeEnabled');
  }

  void _toggleDarkMode(bool value) {
    print('Toggling Dark Mode to: $value');
    setState(() {
      isDarkModeEnabled = value;
      updateTheme(context, value);
      print('Dark Mode State after toggle: $isDarkModeEnabled');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Building Settings Page'); // Debug print
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: null, // disable FAB
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: ArgieColors.dark.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const UserProfileInfoContent(),
                ),
                const SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeading(
                      tittle: 'Account Settings',
                      showActionButton: false,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    const SizedBox(height: 12),

                    SettingMenuTile(
                      icon: Iconsax.lamp,
                      title: 'Dark Mode',
                      subtitle: 'Enable or disable dark mode',
                      trailing: Switch(
                        value: isDarkModeEnabled,
                        onChanged: _toggleDarkMode,
                        activeColor: ArgieColors.primary,
                        inactiveThumbColor: ArgieColors.textsecondary,
                        inactiveTrackColor: ArgieColors.ligth,
                      ),
                      tileColor: Theme.of(context).cardTheme.color,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    SettingMenuTile(
                      icon: Iconsax.notification,
                      title: 'Notifications',
                      subtitle: 'Manage notification preferences',
                      onTap: () {
                        context.go('/setting/notifications');
                      },
                      tileColor: Theme.of(context).cardTheme.color,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    SettingMenuTile(
                      icon: Iconsax.password_check,
                      title: 'Change Password',
                      subtitle: 'Update your account password',
                      onTap: () {
                        context.go('/setting/change-password');
                      },
                      tileColor: Theme.of(context).cardTheme.color,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                    ),

                    const SizedBox(height: 20),

                    SectionHeading(
                      tittle: 'Legal & Support',
                      showActionButton: false,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    const SizedBox(height: 12),

                    SettingMenuTile(
                      icon: Iconsax.security_safe,
                      title: 'Privacy Policy',
                      subtitle: 'Learn how we handle your data',
                      onTap: () {
                        context.go('/setting/privacy-policy');
                      },
                      tileColor: Theme.of(context).cardTheme.color,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    SettingMenuTile(
                      icon: Iconsax.security,
                      title: 'Terms and Conditions',
                      subtitle: 'Review our terms of service',
                      onTap: () {
                        context.go('/setting/terms-conditions');
                      },
                      tileColor: Theme.of(context).cardTheme.color,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    SettingMenuTile(
                      icon: Iconsax.send,
                      title: 'Send Feedback',
                      subtitle: 'Share your experience with us',
                      onTap: () {
                        context.go('/setting/send-feedback');
                      },
                      tileColor: Theme.of(context).cardTheme.color,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                    ),

                    const SizedBox(height: 20),

                    SectionHeading(
                      tittle: 'Logout',
                      showActionButton: false,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    const SizedBox(height: 12),

                    SettingMenuTile(
                      icon: Iconsax.logout,
                      title: 'Logout',
                      subtitle: 'Logout your account now',
                      onTap: () async {
                        print('Logout Button Pressed');
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            content: Text(
                              'Are you sure you want to logout?',
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.poppins(
                                    color: ArgieColors.primary,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  print('Confirmed Logout');
                                  try {
                                    await FirebaseAuth.instance.signOut();
                                    print('Firebase Sign-out successful');
                                    Navigator.pop(context);
                                    if (context.mounted) {
                                      GoRouter.of(context).pushReplacement('/login');
                                    }
                                  } catch (e) {
                                    print('Firebase Sign-out error: $e');
                                    Navigator.pop(context);
                                    if (context.mounted) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            'Error',
                                            style: GoogleFonts.poppins(
                                              color: Theme.of(context).textTheme.bodyLarge?.color,
                                            ),
                                          ),
                                          content: Text(
                                            'Failed to logout. Please try again.',
                                            style: GoogleFonts.poppins(
                                              color: Theme.of(context).textTheme.bodyMedium?.color,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text(
                                                'OK',
                                                style: GoogleFonts.poppins(
                                                  color: ArgieColors.primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  'Logout',
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      tileColor: Theme.of(context).cardTheme.color,
                      textColor: Theme.of(context).textTheme.bodyLarge?.color,
                      subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}