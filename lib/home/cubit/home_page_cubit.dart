import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/home/group_dropdown_widget/view/group_dropdown_widget.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(bool initLoggedIn)
      : super(HomePageState.initial(loggedIn: initLoggedIn));

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
