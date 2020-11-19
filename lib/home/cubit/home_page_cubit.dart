import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState.initial());

  void login() {
    emit(state.copyWith(loggedIn: false));
  }

  void loginFinished() {
    emit(state.copyWith(showGroups: true));
  }

  void openGroups() {
    emit(state.copyWith(showGroups: true));
  }

  void closeGroups() {
    emit(state.copyWith(showGroups: false));
  }
}
