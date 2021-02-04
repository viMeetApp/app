import 'package:bloc/bloc.dart';
import 'package:signup_app/repositories/bugreport_repository.dart';
import 'package:signup_app/repositories/report_repository.dart';
import 'package:signup_app/util/states/vi_form_state.dart';

class ReportCubit extends Cubit<ViFormState> {
  static const int TYPE_POST = 0;
  static const int TYPE_MESSAGE = 1;

  ReportCubit(this._reportRepository)
      : assert(_reportRepository != null),
        super(ViFormState.empty());

  final ReportRepository _reportRepository;

  ///Document gets submitted (User Loggs in)
  ///Checks if User Name Valid the Log In
  void submitted(
      {String id, int type = TYPE_POST, List<String> reasons}) async {
    emit(ViFormState.loading());

    //Check if all fields were answered
    if (id != null && type != null && reasons != null) {
      try {
        /*PackageInfo packageInfo = await PackageInfo.fromPlatform();
        BugReport report = new BugReport();
        report.title = title;
        report.type = type;
        report.message = message;
        report.author = await UserRepository().getUser();
        report.version = packageInfo.version;
        report.timestamp = DateTime.now().millisecondsSinceEpoch;

        await _bugRepository.createBugReport(bugReport: report);*/
        emit(ViFormState.success());
      } catch (err) {
        print("Error in submitted Event");
        print(err.toString());
        emit(ViFormState.error());
      }
    } else {
      //Username invalid
      emit(ViFormState.failure());
    }
  }
}
