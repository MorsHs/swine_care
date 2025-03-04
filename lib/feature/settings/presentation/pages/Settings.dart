import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/feature/advancedrawer/presentation/pages/AdvanceDrawer.dart';
import 'package:swine_care/feature/settings/presentation/widget/SectionHeading.dart';
import 'package:swine_care/feature/settings/presentation/widget/SettingLogoutButton.dart';
import 'package:swine_care/feature/settings/presentation/widget/SettingMenuTile.dart';
import 'package:swine_care/feature/settings/presentation/widget/UserProfileInfoContent.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkModeEnabled = false;

  // Advanced Drawer Controller
  final _drawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return DrawerMenu(
      drawerController: _drawerController,
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                const UserProfileInfoContent(),

                // Body
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Account Settings Section
                      const SectionHeading(
                        tittle: 'Account Settings',
                        showActionButton: false,
                      ),
                      const SizedBox(height: 12),

                      SettingMenuTile(
                        icon: Iconsax.lamp,
                        title: 'Dark Mode',
                        subtitle: 'Enable or disable dark mode',
                        trailing: Switch(
                          value: isDarkModeEnabled,
                          onChanged: (value) {
                            setState(() {
                              isDarkModeEnabled = value;
                            });
                          },
                        ),
                        onTap: () {},
                      ),
                      SettingMenuTile(
                        icon: Iconsax.notification,
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        onTap: () {},
                      ),
                      SettingMenuTile(
                        icon: Iconsax.security_user,
                        title: 'Account Privacy',
                        subtitle: 'Control who can see your information',
                        onTap: () {},
                      ),
                      SettingMenuTile(
                        icon: Iconsax.password_check,
                        title: 'Change Password',
                        subtitle: 'Update your account password',
                        onTap: () {},
                      ),

                      const SizedBox(height: 20),

                      // Legal and Support Section
                      const SectionHeading(
                        tittle: 'Legal & Support',
                        showActionButton: false,
                      ),
                      const SizedBox(height: 12),

                      SettingMenuTile(
                        icon: Iconsax.security_safe,
                        title: 'Privacy Policy',
                        subtitle: 'Learn how we handle your data',
                        onTap: () {},
                      ),
                      SettingMenuTile(
                        icon: Iconsax.security,
                        title: 'Terms and Conditions',
                        subtitle: 'Review our terms of service',
                        onTap: () {},
                      ),
                      SettingMenuTile(
                        icon: Iconsax.send,
                        title: 'Send Feedback',
                        subtitle: 'Share your experience with us',
                        onTap: () {},
                      ),

                      const SizedBox(height: 40),

                      // Logout Button Positioned at the Bottom
                      SettingLogoutButton(),
                      const SizedBox(height: 20),
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