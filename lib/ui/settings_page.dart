import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mensaviewer/data/shared_preferences_helper.dart' as prefs;

/// A settings page that lets the user edit his preferences.
class SettingsPage extends StatefulWidget {

  SettingsPage({Key key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String _versionName = "Unknown";


  @override
  void initState() {
    _initVersionInfo();
  }


  /// Reads the version info of this app from the app's package and updates
  /// this state accordingly.
  Future<void> _initVersionInfo() {
    PackageInfo.fromPlatform()
      .then((value) {
        setState(() {
          _versionName = value.version;
        });
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings'
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildGeneralSettingsSection(context),
          Divider(),
          _buildAboutSection(context),
        ],
      ),
    );
  }

  /// Builds a CheckboxListTile that can be used to modify the value of the
  /// given SharedPreference key.
  Widget _buildSharedPrefSwitchTile(
    BuildContext context, 
    prefs.PreferenceKey key, 
    String title
  ) {
    return FutureBuilder(
      future: prefs.getPreferenceValue(key),
      builder: (context, snapshot) {
        return SwitchListTile(
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

  Widget _buildGeneralSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: Text(
              'General',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          
          _buildSharedPrefSwitchTile(
            context, 
            prefs.userIsStaff, 
            'Show staff prices'
          )
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 8
          ),
          child: Text(
            'About',
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        
        ListTile(
          title: Text(
            'This app is open-source'
          ),
          subtitle: Text(
            'Tap to check it out on GitHub'
          ),
          leading: Icon(
            MdiIcons.githubCircle
          ),
          trailing: Icon(
            MdiIcons.openInNew
          ),
          onTap: () {
            _openGitHubPage();
          },
        ),
        ListTile(
          title: Text(
            'Version'
          ),
          subtitle: Text(
            _versionName
          ),
          leading: Icon(
            MdiIcons.git
          ),
        ),
        ListTile(
          subtitle: Text(
            '(C) 2020 Hauke Sommerfeld\nLicensed under the MIT license.'
          ),
          leading: Icon(
            MdiIcons.copyright
          ),
        )
      ],
    );
  }


  Future<void> _openGitHubPage() async {
    const url = 'https://github.com/haukesomm/mensaviewer';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // TODO: log warning
    }
  }
}