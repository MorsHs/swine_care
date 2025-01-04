import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/colors/colors.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';
import 'package:swine_care/feature/settings/presentation/widget/Activity.dart';
import 'package:swine_care/feature/settings/presentation/widget/AppUpdate.dart';
import 'package:swine_care/feature/settings/presentation/widget/News.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
      title: 'Notifications',
      subtitle: 'Newsletter, App Updates',
    leading: IconWidget(
        icon: Icons.notifications,
        color: appRed
    ),
    child: SettingsScreen(
        children: [
          SizedBox(height: 10),
          buildNews(),
          SizedBox(height: 10),
          buildActivity(),
          SizedBox(height: 10),
          buildAppUpdates(),
        ]
    ),
  );

  }

