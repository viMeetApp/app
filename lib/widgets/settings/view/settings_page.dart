import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/util/widgets/vi_dialog.dart';
import 'package:signup_app/vibit/vibit.dart';
import 'package:signup_app/widgets/settings/cubit/settings_vibit.dart';
import 'package:signup_app/widgets/settings/view/about_widget.dart';
import 'package:signup_app/widgets/settings/view/account_settings_widget.dart';
import 'package:signup_app/widgets/settings/view/language_settings_widget%20copy.dart';
import 'package:signup_app/widgets/settings/view/subsettings_page.dart';

import '../../../util/presets.dart';
import 'accessibility_settings_widget.dart';

class SettingsPage extends StatelessWidget {
  static ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  SettingsPage();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return ViBit<SettingsState>(
        state: SettingsState(),
        onRefresh: (context, state) {
          return Scaffold(
              body: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: ListView(
                    children: [
                      Card(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          shape: _cardShape,
                          color: AppThemeData.colorPrimary,
                          child: ListTile(
                            onTap: () {
                              ViDialog.showTextInputDialog(
                                title: "neuer Name",
                                currentValue: state.user?.name ?? "",
                                context: context,
                                keyboardType: TextInputType.text,
                              ).then((value) {
                                if (value != null) {
                                  state.setName(value);
                                }
                              });
                            },
                            title: Text(
                              state.user != null
                                  ? state.user.name
                                  : "unbekannter Nutzer",
                              style: AppThemeData.textHeading3(
                                  color: Colors.white),
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
                                title: Text("Account"),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () => Navigator.push(
                                    context,
                                    SubSettingsPage.route(
                                        title: "Account",
                                        child: AccountSettingsWidget()))),
                            ListTile(
                                title: Text("Spache"),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () => Navigator.push(
                                    context,
                                    SubSettingsPage.route(
                                        title: "Sprache",
                                        child: LanguageSettingsWidget()))),
                            ListTile(
                                title: Text("Barrierefreiheit"),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: () => Navigator.push(
                                    context,
                                    SubSettingsPage.route(
                                        title: "Barrierefreiheit",
                                        child: AccessibilitySettingsWidget()))),
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        shape: _cardShape,
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () => Navigator.push(
                                  context,
                                  SubSettingsPage.route(
                                      title: "Datenschutz",
                                      child: AboutWidget(
                                          legalFileName: "datenschutz"))),
                              title: Text("Datenschutz"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                            ListTile(
                              onTap: () => Navigator.push(
                                  context,
                                  SubSettingsPage.route(
                                      title: "Impressum",
                                      child: AboutWidget(
                                          legalFileName: "impressum"))),
                              title: Text("Impressum"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            )
                          ],
                        ),
                      ),
                    ],
                  )));
        });
  }
}
