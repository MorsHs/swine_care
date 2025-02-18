
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

final keyDarkmode = 'keyDarkMode';

Widget DarkMode() => SwitchSettingsTile(
    title: 'Dark Mode',
    settingKey: 'keyDarkMode',
    leading: const Icon(Icons.dark_mode, color: Colors.deepPurple),
    onChange: (_) {},
);