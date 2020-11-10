import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/home/group_dropdown_widget/view/group_dropdown_widget.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState.initial());

  void openGroups(context) {
    emit(state.copyWith(showGroups: true));
  }

  void closeGroups(context) {
    emit(state.copyWith(showGroups: false));
  }
}
