import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/widget/ChangePassword.dart';
import 'package:swine_care/feature/settings/presentation/widget/DarkMode.dart';
import 'package:swine_care/feature/settings/presentation/widget/LogoutAccount.dart';
import 'package:swine_care/feature/settings/presentation/widget/ManageNotifications.dart';
import 'package:swine_care/feature/settings/presentation/widget/PrivacyPolicy.dart';
import 'package:swine_care/feature/settings/presentation/widget/Profile.dart';
import 'package:swine_care/feature/settings/presentation/widget/ReportBug.dart';
import 'package:swine_care/feature/settings/presentation/widget/SendFeedback.dart';
import 'package:swine_care/feature/settings/presentation/widget/TermsConditions.dart';
import 'package:swine_care/feature/advancedrawer/presentation/pages/AdvanceDrawer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _drawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return DrawerMenu(
      drawerController: _drawerController,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const ProfileSection(),
            const SizedBox(height: 30),
            DarkMode(),
            const SizedBox(height: 20),
            SettingsGroup(
              title: 'ACCOUNT SETTINGS',
              children: [
                ChangePassword(context),
                ManageNotifications(context),
              ],
            ),
            const SizedBox(height: 20),
            SettingsGroup(
              title: 'SUPPORT',
              children: [
                ReportBug(context),
                SendFeedback(context),
                PrivacyPolicy(context),
                TermsAndConditions(context),
              ],
            ),
            const SizedBox(height: 20),
            SettingsGroup(
              title: 'LOGOUT',
              children: [
                LogoutAccount(context)
              ],
            ),
          ],
        ),
      ),
    );
  }
}