import 'package:bloc/bloc.dart';
import 'package:signup_app/repositories/report_repository.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/states/vi_form_state.dart';

class ReportCubit extends Cubit<ViFormState> {
  ReportCubit(this._reportRepository)
      : assert(_reportRepository != null),
        super(ViFormState.invalid());

  final ReportRepository _reportRepository;

  void submitted(
      {String id, String type = Report.TYPE_POST, List<String> reasons}) async {
    emit(ViFormState.loading());

    if (id != null && type != null && reasons != null) {
      try {
        Report report = new Report();
        report.id = id;
        report.type = type;
        report.reasons = reasons;
        report.author = await UserRepository().getUser();
        report.timestamp = DateTime.now().millisecondsSinceEpoch;

        await _reportRepository.createReport(report: report);
        emit(ViFormState.success());
      } catch (err) {
        print("Error in submitted Report");
        print(err.toString());
        emit(ViFormState.error());
      }
    } else {
      emit(ViFormState.invalid());
    }
  }

  void updateValid(bool reasonsEmpty) {
    emit(reasonsEmpty ? ViFormState.invalid() : ViFormState.okay());
  }
}
