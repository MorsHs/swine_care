import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';

Widget PrivacyPage(BuildContext context) => SimpleSettingsTile(
      title: "Privacy",
      subtitle: " ",
      leading: const IconWidget(
        icon: Icons.lock,
        color: Colors.cyan,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PrivacyPage(context)),
        );
      },
    );
