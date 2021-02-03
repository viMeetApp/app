import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/repositories/bugreport_repository.dart';
import 'package:signup_app/widgets/bug_report/cubit/bug_report_cubit.dart';
import 'package:signup_app/widgets/bug_report/view/widgets/bug_report_form.dart';

class BugReportPage extends StatelessWidget {
  ///Set Group argument when post is Created out of Group
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => BugReportPage());
  }

  String _title;
  String _type;
  String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Problem melden"),
      ),
      body: BlocProvider<BugReportCubit>(
        create: (_) => BugReportCubit(BugReportRepository()),
        child: BugReportForm(),
      ),
    );
  }
}
