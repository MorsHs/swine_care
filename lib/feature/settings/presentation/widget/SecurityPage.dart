import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/colors/colors.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';
import 'package:swine_care/feature/settings/presentation/widget/Utils.dart';


Widget SecurityPage(BuildContext context) => SimpleSettingsTile(
  title: "Security",
  subtitle: " ",
  leading: const IconWidget(
    icon:Icons.security,
    color: appBlue,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Security'),
);