part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {}

class Uninitilaized extends AuthenticationState {}

///State when authenticated. State stores a reference to current User
class Authenticated extends AuthenticationState {
  final User user;
  final UserReference userReference;
  Authenticated({required this.user, required this.userReference});
}

///State when not authenticated yet
class Unauthenticated extends AuthenticationState {}
