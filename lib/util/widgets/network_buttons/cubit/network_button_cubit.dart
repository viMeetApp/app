import 'package:bloc/bloc.dart';

class NetworkButtonCubit extends Cubit<bool> {
  NetworkButtonCubit() : super(false);

  void isLoading() {
    emit(true);
  }

  void isNotLoading() {
    emit(false);
  }
}
