import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

Widget PrivacyPage(BuildContext context) => SimpleSettingsTile(
  title: "Privacy",
  subtitle: " ",
  leading: const Icon(
    Icons.lock,
    color: Colors.cyan,
  ),
    onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => PrivacyPage(context)),
);
},
);