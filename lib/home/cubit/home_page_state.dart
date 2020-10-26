part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  final bool showGroups;
  final int currentPage;

  HomePageState({this.showGroups, this.currentPage});

  factory HomePageState.initial()=>HomePageState(currentPage: 0, showGroups: false);

  HomePageState copyWith({int currentPage, bool showGroups}){
    return HomePageState(currentPage: currentPage??this.currentPage, showGroups: showGroups??this.showGroups);
  }
}

