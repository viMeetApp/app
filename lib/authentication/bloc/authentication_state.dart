part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class Uninitilaized extends AuthenticationState {}

///State when authenticated. State stores a reference to current User
class Authenticated extends AuthenticationState {
  final User user;
  Authenticated({@required this.user}) : assert(user != null);
}

///State when not authenticated yet
class Unauthenticated extends AuthenticationState {}
