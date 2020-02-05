import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mensaviewer/data/shared_preferences_helper.dart' as prefs;


/// A settings page that lets the user edit his preferences.
class SettingsPage extends StatefulWidget {

  SettingsPage({Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings'
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildSharedPrefCheckboxTile(
            context, 
            prefs.userIsStaff, 
            'Show staff prices'
          )
        ],
      ),
    );
  }

  /// Builds a CheckboxListTile that can be used to modify the value of the
  /// given SharedPreference key.
  Widget _buildSharedPrefCheckboxTile(
    BuildContext context, 
    prefs.PreferenceKey key, 
    String title
  ) {
    return FutureBuilder(
      future: prefs.getPreferenceValue(key),
      builder: (context, snapshot) {
        return CheckboxListTile(
          title: Container(
            child: Text(
              title
            )
          ),
          value: snapshot.data ?? key.defaultValue, 
          onChanged: (value) {
            setState(() {
              prefs.putPreferenceValue(key, value);
            });
          }
        );
      },
    );
  }
}