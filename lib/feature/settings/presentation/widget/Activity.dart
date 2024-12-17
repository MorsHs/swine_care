
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/colors/colors.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';

final keyActivity = 'keyActivity';

Widget buildActivity() => SwitchSettingsTile(
    title: 'News For You',
    settingKey: keyActivity,
    leading: IconWidget(
        icon: Icons.message,
        color: appBlue)
);