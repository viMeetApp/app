import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/vibit/vibit.dart';
import 'package:signup_app/widgets/bug_report/cubit/bug_report_vibit.dart';

class BugReportPage extends StatelessWidget {
  ///Set Group argument when post is Created out of Group
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => BugReportPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fehler melden"),
        ),
        body: ViBit<BugReportPageState>(
            state: BugReportPageState(),
            onChangeLogic: (state) {
              switch (state.type) {
                case Types.submitted:
                  Tools.showSuccessPage(context, message: "Danke!");
                  break;
                case Types.invalid:
                  Tools.showSnackbar(context, "Bitte fülle alles aus");
                  break;
                case Types.error:
                  Tools.showSnackbar(context, "Fehler beim Speichern");
                  break;
                default:
              }
            },
            onRefresh: (context, state) => Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    //runSpacing: 10,
                    //spacing: 10,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "👋 Hilf uns die App zu verbessern",
                          style: AppThemeData.textHeading2(
                              color: AppThemeData.colorTextRegular),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Dir ist ein Fehler in der App aufgefallen? Dann würden wir uns sehr freuen wenn du uns hilfst diesen schnellstmöglich zu beheben indem du uns kurz mitteilst worum es geht:",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      TextField(
                        enabled: state.type != Types.processing,
                        decoration: Presets.getTextFieldDecorationHintStyle(
                            hintStyle: TextStyle(
                                color: AppThemeData.colorTextRegularLight),
                            hintText: "kurze Beschreibung"),
                        onChanged: (newValue) {
                          state.title = newValue;
                        },
                      ),
                      Presets.simpleCard(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ViDropdownButton(
                            elements: [
                              ViDropdownItem(
                                  BugReportType.ui, "Benutzeroberfläche"),
                              ViDropdownItem(BugReportType.logic, "App Logik"),
                              ViDropdownItem(BugReportType.functionality,
                                  "fehlende Funktion"),
                              ViDropdownItem(BugReportType.request,
                                  "Vorschlag für eine Funktion"),
                              ViDropdownItem(BugReportType.other, "sonstige"),
                            ],
                            hint: "Typ des Problems",
                            onChanged: (value) {
                              state.kind = value;
                            },
                          )),
                      TextField(
                          enabled: state.type != Types.processing,
                          minLines: 10,
                          maxLines: 10,
                          decoration: Presets.getTextFieldDecorationHintStyle(
                              hintStyle: TextStyle(
                                  color: AppThemeData.colorTextRegularLight),
                              hintText:
                                  "Schildere das Problem kurz:\n- wann tritt er auf \n- was geschieht nach dem Fehler"),
                          onChanged: (String newValue) {
                            state.message = newValue;
                          }),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                    heroTag: "bugrep_success",
                    onPressed: () {
                      state.submitted();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )))));
  }
}
