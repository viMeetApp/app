import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/repositories/report_repository.dart';
import 'package:signup_app/widgets/report/cubit/report_cubit.dart';
import 'package:signup_app/widgets/report/view/widgets/report_form.dart';

class ReportDialog extends StatelessWidget {
  List<String> reasons = [];

  String id;
  String reportType;
  BuildContext parentContext;

  ReportDialog(
      {@required this.id,
      @required this.reportType,
      @required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppThemeData.colorBase,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.all(AppThemeData.varPaddingCard * 3),
        child: Container(
          padding: EdgeInsets.all(20),
          child: BlocProvider<ReportCubit>(
            create: (_) => ReportCubit(ReportRepository()),
            child: ReportForm(
              id: id,
              reportType: reportType,
              parentContext: parentContext,
            ),
          ),
        ),
      ),
    );
  }
}
