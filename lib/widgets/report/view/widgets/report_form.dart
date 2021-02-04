import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/util/states/vi_form_state.dart';
import 'package:signup_app/util/widgets/vi_selectable_chip.dart';
import 'package:signup_app/widgets/report/cubit/report_cubit.dart';

class _ReportReason {
  const _ReportReason(this.id, this.name);
  final String id;
  final String name;
}

const REPORT_REASONS = <_ReportReason>[
  _ReportReason("harassment", "Beleidigung"),
  _ReportReason("hate", "Hass"),
  _ReportReason("violance", "Androhung von Gewalt"),
  _ReportReason("sexualization", "Sexualisierung"),
  _ReportReason("copyright", "Copyright Verstoß"),
  _ReportReason("misinformation", "Falschinformation"),
  _ReportReason("spam", "Spam"),
];

class ReportForm extends StatelessWidget {
  String id;
  int reportType = 0;
  List<String> reasons = [];

  ReportForm({@required this.id, @required this.reportType});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportCubit, ViFormState>(
      listener: (context, state) {
        //When Logged In -> Call Authetication Bloc with Logged in
        if (state.wasSubmitted) {
          Navigator.of(context).pop();
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
      child: BlocBuilder<ReportCubit, ViFormState>(
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Post melden",
                style: AppThemeData.textHeading2(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 0.0,
                  children: List<Widget>.generate(
                      REPORT_REASONS
                          .length, // place the length of the array here
                      (int index) {
                    return ViSelectableChip(
                      label: Text(REPORT_REASONS[index].name),
                      onChanged: (selected) {
                        if (selected) {
                          reasons.add(REPORT_REASONS[index].id);
                          return;
                        }
                        reasons.remove(REPORT_REASONS[index].id);
                      },
                    );
                  }).toList(),
                ),
              ),
              RaisedButton(
                child: Text("melden"),
                onPressed: () {
                  BlocProvider.of<ReportCubit>(context)
                      .submitted(id: id, type: reportType, reasons: reasons);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
