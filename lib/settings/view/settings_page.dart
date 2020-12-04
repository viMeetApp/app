import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:signup_app/util/presets.dart';

import '../../util/presets.dart';

class SettingsPage extends StatelessWidget {
  static ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  SettingsPage() {}

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppThemeData.colorControls),
          backgroundColor: Colors.transparent,
          title: Text(
            "Einstellungen",
            style: TextStyle(color: AppThemeData.colorTextRegular),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ListView(
              children: [
                Card(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    shape: _cardShape,
                    color: AppThemeData.colorPrimary,
                    child: ListTile(
                      onTap: () => {},
                      title: Text(
                        "Max Mustermann",
                        style: AppThemeData.textHeading3(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )),
                Card(
                  margin: EdgeInsets.all(10),
                  shape: _cardShape,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => {},
                        title: Text("Account"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      ListTile(
                        onTap: () => {},
                        title: Text("Spache"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      ListTile(
                        title: Text("Impressum"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  shape: _cardShape,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Datenschutz"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      ListTile(
                        title: Text("Impressum"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
