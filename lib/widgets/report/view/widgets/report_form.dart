import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/util/states/vi_form_state.dart';
import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/util/widgets/vi_selectable_chip.dart';
import 'package:signup_app/widgets/report/cubit/report_cubit.dart';

class ReportForm extends StatelessWidget {
  final BuildContext parentContext;
  final String? id;
  final ReportType reportType;
  final List<ReportReason> reasons = [];

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
          Tools.showSnackbar(context, "Danke");

          return null;
        }
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
                        ReportType.values
                            .length, // place the length of the array here
                        (int index) {
                      return ViSelectableChip(
                        isActive: reasons.contains(ReportReason.values[index]),
                        label: Text(ReportReason.values[index].toString()),
                        onChanged: (selected) {
                          if (selected) {
                            reasons.add(ReportReason.values[index]);
                          } else {
                            reasons.remove(ReportReason.values[index]);
                          }
                          BlocProvider.of<ReportCubit>(context)
                              .updateValid(reasons.length == 0);
                        },
                      );
                    }).toList(),
                  ),
                ),
                !state.isSubmitting
                    ? TextButton(
                        child: Text(
                          "melden",
                          style: TextStyle(
                            color: AppThemeData.colorCard,
                          ),
                        ),
                        onPressed: state.isValid
                            ? () {
                                BlocProvider.of<ReportCubit>(context).submitted(
                                    documentReference: "ToDo",
                                    type: reportType,
                                    reasons: reasons,
                                    context: context);
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
