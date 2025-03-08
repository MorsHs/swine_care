import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/feature/settings/presentation/widget/SectionHeading.dart';
import 'package:swine_care/feature/settings/presentation/widget/SettingLogoutButton.dart';
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
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                  onTap: () {},
                  tileColor: Theme.of(context).cardTheme.color,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                SettingMenuTile(
                  icon: Iconsax.security_user,
                  title: 'Account Privacy',
                  subtitle: 'Control who can see your information',
                  onTap: () {},
                  tileColor: Theme.of(context).cardTheme.color,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                SettingMenuTile(
                  icon: Iconsax.password_check,
                  title: 'Change Password',
                  subtitle: 'Update your account password',
                  onTap: () {},
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
                  onTap: () {},
                  tileColor: Theme.of(context).cardTheme.color,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                SettingMenuTile(
                  icon: Iconsax.security,
                  title: 'Terms and Conditions',
                  subtitle: 'Review our terms of service',
                  onTap: () {},
                  tileColor: Theme.of(context).cardTheme.color,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                ),
                SettingMenuTile(
                  icon: Iconsax.send,
                  title: 'Send Feedback',
                  subtitle: 'Share your experience with us',
                  onTap: () {},
                  tileColor: Theme.of(context).cardTheme.color,
                  textColor: Theme.of(context).textTheme.bodyLarge?.color,
                  subtitleColor: Theme.of(context).textTheme.bodyMedium?.color,
                ),

                const SizedBox(height: 60),
                SettingLogoutButton(),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}