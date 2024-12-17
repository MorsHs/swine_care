
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:swine_care/feature/settings/presentation/widget/Icon.dart';

final keyDarkmode = 'keyDarkMode';

Widget DarkMode() => SwitchSettingsTile(
    title: 'Dark Mode',
    settingKey: keyDarkmode,
    leading: IconWidget(
        icon: Icons.dark_mode,
        color: Color(0xFF642ef3),
    ),
  onChange: (_){},
);