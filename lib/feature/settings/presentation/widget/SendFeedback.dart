import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';
import 'package:swine_care/feature/settings/presentation/widget/Utils.dart';

Widget SendFeedback(BuildContext context) => SimpleSettingsTile(
  title: "Send Feedback",
  subtitle: " ",
  leading: const IconWidget(
    icon: Icons.feedback,
    color: Colors.teal,
  ),
  onTap: () => Utils.showSnackBar(context, 'Clicked Send Feedback'),
);