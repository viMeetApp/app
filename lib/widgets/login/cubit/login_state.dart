part of 'login_cubit.dart';

@immutable
class LoginState {
  final bool isNameValid;
  final bool isSubmitting;
  final bool isError;
  final bool isLoggedIn;

  LoginState(
      {required this.isNameValid,
      required this.isSubmitting,
      required this.isError,
      required this.isLoggedIn});
  factory LoginState.empty() {
    return LoginState(
        isNameValid: true,
        isSubmitting: false,
        isError: false,
        isLoggedIn: false);
  }

  factory LoginState.loading() {
    return LoginState(
        isNameValid: true,
        isSubmitting: true,
        isError: false,
        isLoggedIn: false);
  }
  factory LoginState.failure() {
    return LoginState(
        isSubmitting: false,
        isNameValid: false,
        isError: false,
        isLoggedIn: false);
  }
  factory LoginState.success() {
    return LoginState(
        isSubmitting: false,
        isNameValid: true,
        isError: false,
        isLoggedIn: true);
  }
  factory LoginState.error() {
    return LoginState(
        isSubmitting: false,
        isNameValid: true,
        isError: true,
        isLoggedIn: false);
  }
}
