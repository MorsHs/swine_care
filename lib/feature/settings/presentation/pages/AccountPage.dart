import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/widget/AccountInfo.dart';
import 'package:swine_care/feature/settings/presentation/widget/PrivacyPage.dart';
import 'package:swine_care/feature/settings/presentation/widget/SecurityPage.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Account Setting",
      subtitle: "Privacy, Security, Language",
      leading: Icon(
        Icons.person,
        color: Colors.green,
      ),
     child: SettingsScreen(
       title: 'Account Settings' ,
         children:[
           PrivacyPage(context),
           SecurityPage(context),
           AccountInfo(context),
         ]),
    );
  }
}
