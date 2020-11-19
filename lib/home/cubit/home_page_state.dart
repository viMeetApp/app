part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  //
  bool showGroups;
  final bool loggedIn;
  final int currentPage;

  HomePageState({this.showGroups, this.currentPage, this.loggedIn}) {
    // if user is not logged in showing groups should not be possible
    this.showGroups = (!showGroups ? false : showGroups);
  }

  factory HomePageState.initial() =>
      HomePageState(currentPage: 0, showGroups: false, loggedIn: false);

  HomePageState copyWith({int currentPage, bool showGroups, bool loggedIn}) {
    return HomePageState(
        currentPage: currentPage ?? this.currentPage,
        loggedIn: loggedIn ?? this.loggedIn,
        showGroups: showGroups ?? this.showGroups);
  }
}
