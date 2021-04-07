import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/repositories/report_repository.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/services/authentication/cubit/authentication_cubit.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/states/vi_form_state.dart';

class ReportCubit extends Cubit<ViFormState> {
  ReportCubit(this._reportRepository) : super(ViFormState.invalid());

  final ReportRepository _reportRepository;

  void submitted(
      {required String documentReference,
      required ReportType type,
      required List<ReportReason> reasons,
      required BuildContext context}) async {
    emit(ViFormState.loading());

    if (reasons.length == 0) {
      try {
        final author = (BlocProvider.of<AuthenticationCubit>(context).state
                as Authenticated)
            .userReference;
        Report report = new Report(
            author: author,
            reasons: reasons,
            reportedAt: DateTime.now().millisecondsSinceEpoch,
            type: type,
            state: ReportState.open,
            objectReference: '' //ToDo Real Object reference
            );

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
