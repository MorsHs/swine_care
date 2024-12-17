import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';
import 'package:swine_care/feature/settings/presentation/widget/Utils.dart';

Widget ReportBug(BuildContext context) => SimpleSettingsTile(
  title: "Report A Bug",
  subtitle: " ",
  leading: const IconWidget(
    icon:Icons.bug_report,
    color: Colors.teal,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Report A Bug'),
);