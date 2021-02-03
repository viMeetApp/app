import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/repositories/bugreport_repository.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/util/widgets/vi_dropdown_button.dart';
import 'package:signup_app/widgets/bug_report/cubit/bug_report_cubit.dart';

class BugReportForm extends StatelessWidget {
  String _title;
  String _type;
  String _message;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BugReportCubit, BugReportState>(
        listener: (context, state) {
          //When Logged In -> Call Authetication Bloc with Logged in
          if (state.wasSubmitted) {
            Navigator.of(context).pop();
            return null;
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
                            "Diese Beschreibung wird an die Entwickler von viMeet übermittelt. Deine Beschreibung hilft uns sehr unsere App zu verbessern. Danke :)",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        TextField(
                          decoration: Presets.getTextFieldDecorationHintStyle(
                              hintText: "Kurzbeschreibung"),
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
                                'sonstige'
                              ],
                              hint: "Typ des Problems",
                              onChanged: (value) {
                                _type = value;
                              },
                            )),
                        TextField(
                            minLines: 10,
                            maxLines: 10,
                            decoration: Presets.getTextFieldDecorationHintStyle(
                                hintText:
                                    "Beschreibung des Problems\n- wann tritt er auf \n- was geschieht nach dem Fehler"),
                            onChanged: (String newValue) {
                              _message = newValue;
                            }),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
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
