import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/colors/colors.dart';
import 'package:swine_care/feature/settings/presentation/widget/Utils.dart';

Widget DeleteAccount(BuildContext context) => SimpleSettingsTile(
  title: "Delete Account",
  subtitle: " ",
  leading: const Icon(
    Icons.delete,
    color: appRed,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Delete'),
);