import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(LoginState.empty());

  final AuthenticationRepository _authenticationRepository;

  ///Document gets submitted (User Loggs in)
  ///Checks if User Name Valid the Log In
  void submitted(String username) async {
    emit(LoginState.loading());

    //Check if User Name is Valid
    if (username != null && username.length != 0) {
      try {
        await _authenticationRepository.signUpAnonymously(username);
        emit(LoginState.succes());
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
