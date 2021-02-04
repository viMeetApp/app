import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:signup_app/repositories/bugreport_repository.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/states/vi_form_state.dart';

class BugReportCubit extends Cubit<ViFormState> {
  BugReportCubit(this._bugRepository)
      : assert(_bugRepository != null),
        super(ViFormState.okay());

  final BugReportRepository _bugRepository;

  ///Document gets submitted (User Loggs in)
  ///Checks if User Name Valid the Log In
  void submitted(String title, String type, String message) async {
    emit(ViFormState.loading());

    //Check if all fields were answered
    if (title != null && type != null && message != null) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        BugReport report = new BugReport();
        report.title = title;
        report.type = type;
        report.message = message;
        report.author = await UserRepository().getUser();
        report.version = packageInfo.version;
        report.timestamp = DateTime.now().millisecondsSinceEpoch;

        await _bugRepository.createBugReport(bugReport: report);
        emit(ViFormState.success());
      } catch (err) {
        print("Error in submitted Event");
        print(err.toString());
        emit(ViFormState.error());
      }
    } else {
      //Username invalid
      emit(ViFormState.invalid());
    }
  }
}
