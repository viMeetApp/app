import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._userRepository)
      : assert(_userRepository != null),
        super(LoginState.empty());

  final UserRepository _userRepository;

  ///Document gets submitted (User Loggs in)
  ///Checks if User Name Valid the Log In
  void submitted(String username) async {
    emit(LoginState.loading());

    //Check if User Name is Valid
    if (username != null && username.length != 0) {
      try {
        await _userRepository.signUpAnonymously(username);
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
