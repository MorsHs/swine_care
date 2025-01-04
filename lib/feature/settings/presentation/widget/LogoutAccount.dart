import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';
import 'package:swine_care/feature/settings/presentation/widget/Utils.dart';

Widget LogoutAccount(BuildContext context) => SimpleSettingsTile(
  title: "Logout",
  subtitle: " ",
  leading: const IconWidget(
      icon: Icons.logout_outlined,
      color: Colors.blue
  ),
      onTap: () => Utils.showSnackBar(context, 'Clicked Logout'),
);