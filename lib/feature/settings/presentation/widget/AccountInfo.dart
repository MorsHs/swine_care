import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/colors/colors.dart';
import 'package:swine_care/feature/settings/presentation/widget/Utils.dart';


Widget AccountInfo(BuildContext context) => SimpleSettingsTile(
  title: "Account",
  subtitle: " ",
  leading: const Icon(
    Icons.account_box,
    color: appGreen,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Account Info'),
);