import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/util/states/vi_form_state.dart';
import 'package:signup_app/util/widgets/vi_selectable_chip.dart';
import 'package:signup_app/widgets/report/cubit/report_cubit.dart';
import 'package:signup_app/widgets/report/view/widgets/report_success_dialog.dart';

class ReportForm extends StatelessWidget {
  BuildContext parentContext;
  String? id;
  String reportType = Report.TYPE_POST;
  List<String> reasons = [];

  ReportForm(
      {required this.id,
      required this.reportType,
      required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportCubit, ViFormState>(
      listener: (context, state) {
        if (state.wasSubmitted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Scaffold.of(parentContext)
              .showSnackBar(SnackBar(content: Text("Danke!")));

          return null;
        }

        //When Logged In -> Call Authetication Bloc with Logged in
        /*if (state.wasSubmitted) {
          Navigator.of(context).pop();
        }*/

        /*if (!state.isValid) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Bitte fülle alles aus")));
        }

        if (state.isError) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Fehler beim Speichern")));
        }*/
      },
      child: BlocBuilder<ReportCubit, ViFormState>(
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          return Hero(
            tag: "report_success",
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Post melden",
                  style: AppThemeData.textHeading2(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: List<Widget>.generate(
                        Report.REPORT_REASONS
                            .length, // place the length of the array here
                        (int index) {
                      return ViSelectableChip(
                        isActive:
                            reasons.contains(Report.REPORT_REASONS[index].id),
                        label: Text(Report.REPORT_REASONS[index].name),
                        onChanged: (selected) {
                          if (selected) {
                            reasons.add(Report.REPORT_REASONS[index].id);
                          } else {
                            reasons.remove(Report.REPORT_REASONS[index].id);
                          }
                          BlocProvider.of<ReportCubit>(context)
                              .updateValid(reasons.length == 0);
                        },
                      );
                    }).toList(),
                  ),
                ),
                !state.isSubmitting
                    ? FlatButton(
                        child: Text(
                          "melden",
                          style: TextStyle(
                            color: AppThemeData.colorCard,
                          ),
                        ),
                        color: AppThemeData.colorPrimary,
                        disabledColor: AppThemeData.colorControlsDisabled,
                        onPressed: state.isValid
                            ? () {
                                BlocProvider.of<ReportCubit>(context).submitted(
                                    id: id, type: reportType, reasons: reasons);
                              }
                            : null,
                      )
                    : Center(child: CircularProgressIndicator()),
                if (state.isError)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Fehler beim Abschicken",
                      textAlign: TextAlign.center,
                      style: AppThemeData.textNormal(
                          fontWeight: FontWeight.bold,
                          color: AppThemeData.colorPrimary),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
