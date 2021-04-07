import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/tools/debug_tools.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(Uninitilaized());

  final UserRepository _userRepository = UserRepository();

  void appStarted() async {
    try {
      final _isSignedIn = await _userRepository.isSignedIn();
      if (_isSignedIn) {
        final User user = await _userRepository.getUserFromDatabase();
        final UserReference userReference = new UserReference(
            name: user.name, id: user.id, picture: user.picture);
        emit(Authenticated(user: user, userReference: userReference));
      } else {
        emit(Unauthenticated());
      }
    } catch (err) {
      viLog(err, "Error in Event App Started");
      emit(Unauthenticated());
    }
  }

  void loggedIn() async {
    final User user = await _userRepository.getUserFromDatabase();
    final UserReference userReference =
        new UserReference(name: user.name, id: user.id, picture: user.picture);
    emit(Authenticated(user: user, userReference: userReference));
  }
}
