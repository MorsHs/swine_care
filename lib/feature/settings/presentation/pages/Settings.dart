import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/pages/AccountPage.dart';
import 'package:swine_care/feature/settings/presentation/widget/DarkMode.dart';
import 'package:swine_care/feature/settings/presentation/widget/LogoutAccount.dart';
import 'package:swine_care/feature/settings/presentation/pages/Notifications.dart';
import 'package:swine_care/feature/settings/presentation/widget/Profile.dart';
import 'package:swine_care/feature/settings/presentation/widget/ReportBug.dart';
import 'package:swine_care/feature/settings/presentation/widget/SendFeedback.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
           const ProfilePage(),
            const SizedBox(height: 30),
            DarkMode(),
            const SizedBox(height: 10),
            const SettingsGroup(
                title: 'GENERAL',
                children:[
                  AccountPage(),
                  Notifications(),
                ],
            ),
            SettingsGroup(
              title: 'FEEDBACK',
              children:[
                ReportBug(context),
                SendFeedback(context),
              ],
            ),
            SettingsGroup(
              title: 'LOGOUT',
              children:[
                LogoutAccount(context),
              ],
            ),
            ],
        ),
      )
    );
  }
}
