import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/common.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({AuthenticationService? authenticationService})
      : _authenticationService =
            authenticationService ?? AuthenticationService(),
        super(Uninitilaized());

  final AuthenticationService _authenticationService;
  void appStarted() async {
    try {
      final _isSignedIn = await _authenticationService.isSignedIn();
      if (_isSignedIn) {
        final User user = _authenticationService.getCurrentUser();
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
    final User user = _authenticationService.getCurrentUser();
    final UserReference userReference =
        new UserReference(name: user.name, id: user.id, picture: user.picture);
    emit(Authenticated(user: user, userReference: userReference));
  }
}
