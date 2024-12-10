import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/pages/AccountPage.dart';
import 'package:swine_care/feature/settings/presentation/widget/DeleteAccount.dart';
import 'package:swine_care/feature/settings/presentation/widget/LogoutAccount.dart';
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
            SettingsGroup(
                title: 'GENERAL',
                children:[
                  const AccountPage(),
                  LogoutAccount(context),
                  DeleteAccount(context),
                ],
            ),
            SettingsGroup(
              title: 'GENERAL',
              children:[
                ReportBug(context),
                SendFeedback(context),
              ],
            ),
        
            ],
        ),
      )
    );
  }
}
