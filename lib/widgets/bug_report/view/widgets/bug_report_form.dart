import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/repositories/bugreport_repository.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/util/widgets/vi_dropdown_button.dart';
import 'package:signup_app/widgets/bug_report/cubit/bug_report_cubit.dart';
import 'package:signup_app/widgets/bug_report/view/widgets/bug_report_success.dart';

class BugReportForm extends StatelessWidget {
  String _title;
  String _type;
  String _message;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BugReportCubit, BugReportState>(
        listener: (context, state) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return BugReportSuccessPage();
          }));
          //When Logged In -> Call Authetication Bloc with Logged in
          if (state.wasSubmitted) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return BugReportSuccessPage();
            }));
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });

            return null;
          }

          if (!state.isValid) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Bitte fülle alles aus")));
          }

          if (state.isError) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Fehler beim Speichern")));
          }
        },
        child: BlocBuilder<BugReportCubit, BugReportState>(
            buildWhen: (previous, current) => true,
            builder: (context, state) {
              return Scaffold(
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
                          enabled: !state.wasSubmitted,
                          decoration: Presets.getTextFieldDecorationHintStyle(
                              hintStyle: TextStyle(
                                  color: AppThemeData.colorTextRegularLight),
                              hintText: "kurze Beschreibung"),
                          onChanged: (newValue) {
                            _title = newValue;
                          },
                        ),
                        Presets.simpleCard(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ViDropdownButton(
                              elements: <String>[
                                'Benutzeroberfläche',
                                'App Logik',
                                'fehlende Funktion',
                                'Vorschlag für eine Funktion',
                                'sonstige'
                              ],
                              hint: "Typ des Problems",
                              onChanged: (value) {
                                _type = value;
                              },
                            )),
                        TextField(
                            enabled: !state.wasSubmitted,
                            minLines: 10,
                            maxLines: 10,
                            decoration: Presets.getTextFieldDecorationHintStyle(
                                hintStyle: TextStyle(
                                    color: AppThemeData.colorTextRegularLight),
                                hintText:
                                    "Schildere das Problem kurz:\n- wann tritt er auf \n- was geschieht nach dem Fehler"),
                            onChanged: (String newValue) {
                              _message = newValue;
                            }),
                      ],
                    ),
                  ),
                  /*floatingActionButton: OpenContainer(
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    openColor: Colors.transparent,
                    openElevation: 0,
                    transitionDuration: Duration(milliseconds: 500),
                    closedBuilder: (BuildContext c, VoidCallback action) =>
                        FloatingActionButton(
                            elevation: 0, child: Icon(Icons.add)),
                    openBuilder: (BuildContext c, VoidCallback action) =>
                        SplashPage(),
                    tappable: true,
                  )*/

                  floatingActionButton: FloatingActionButton(
                      heroTag: "bugrep_success",
                      onPressed: () {
                        BlocProvider.of<BugReportCubit>(context)
                            .submitted(_title, _type, _message);
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      )));
            }));
  }
}
