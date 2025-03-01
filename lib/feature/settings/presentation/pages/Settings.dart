import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/feature/settings/presentation/widget/SectionHeading.dart';
import 'package:swine_care/feature/settings/presentation/widget/SettingMenuTile.dart';
import 'package:swine_care/feature/settings/presentation/widget/UserProfileInfoContent.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              const UserProfileInfoContent(),

              // Body
              Padding(
                padding: EdgeInsets.all(ArgieSizes.defaultSpace),
                child: Column(
                  children: [
                    const SectionHeading(tittle: 'Account Settings',showActionButton: false, ),
                    SizedBox(height: ArgieSizes.spaceBwtItem),

                    SettingMenuTile(
                      icon: Iconsax.lamp,
                      title: 'Dark Mode',
                      subtitle: 'Enable or disable dark mode',
                      trailing: Switch(value: false, onChanged: (value) {}),
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

                    const SizedBox(height: 60),

                    // Logout Button Positioned at the Bottom
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),

                    SizedBox(height: ArgieSizes.spaceBwtItem),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
