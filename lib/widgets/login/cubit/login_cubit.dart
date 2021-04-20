import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({AuthenticationService? authenticationService})
      : _authenticationService =
            authenticationService ?? AuthenticationService(),
        super(LoginState.empty());

  final AuthenticationService _authenticationService;

  ///Document gets submitted (User Loggs in)
  ///Checks if User Name Valid the Log In
  void submitted(String username) async {
    emit(LoginState.loading());

    //Check if User Name is Valid
    if (username.length != 0) {
      try {
        await _authenticationService.signUpAnonymously(username);
        emit(LoginState.success());
      } catch (err) {
        print("Error in submitted Event");
        print(err.toString());
        emit(LoginState.error());
      }
    } else {
      //Username invalid
      emit(LoginState.failure());
    }
  }
}
