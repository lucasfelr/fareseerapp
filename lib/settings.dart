import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'nfcpage.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String email = '';
  String password = '';
  String aux = '';
  var value = false;

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Section',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              title: 'Use fingerprint',
              leading: Icon(Icons.fingerprint),
              switchValue: value,
              onToggle: (bool value) {},
            ),
          ],
        ),
      ],
    );
  }
}
