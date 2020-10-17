part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent{}

class LoggedIn extends AuthenticationEvent{}