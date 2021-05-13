part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  //
  final bool? showGroups;
  final bool? loggedIn;
  final int? currentPage;

  HomePageState({this.showGroups, this.currentPage, this.loggedIn}) {
    //ToDo fix this
    // if user is not logged in showing groups should not be possible
    //this.showGroups = (!showGroups! ? false : showGroups);
  }

  factory HomePageState.initial({bool? loggedIn = false}) =>
      HomePageState(currentPage: 0, showGroups: false, loggedIn: loggedIn);

  HomePageState copyWith({int? currentPage, bool? showGroups, bool? loggedIn}) {
    return HomePageState(
        currentPage: currentPage ?? this.currentPage,
        loggedIn: loggedIn ?? this.loggedIn,
        showGroups: showGroups ?? this.showGroups);
  }
}
