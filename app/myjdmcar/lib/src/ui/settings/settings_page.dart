import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/settings/settings_listtile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(AppLocalizations.of(context).translate("settingsPageTitle"),
              style: Theme.of(context).textTheme.headline6)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsListTile(
            title: AppLocalizations.of(context).translate("changeUsernamePageTitle"),
            routeName: "change_username_page",
          ),
          SettingsListTile(
            title: AppLocalizations.of(context).translate("changePasswordPageTitle"),
            routeName: "change_password_page",
          ),
          SettingsListTile(
            title: AppLocalizations.of(context).translate("appInfoPage"),
            routeName: "info_page",
          ),
        ],
      ),
    );
  }
}
