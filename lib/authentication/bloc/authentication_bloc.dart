import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(Uninitilaized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // implement mapEventToState
    if (event is AppStarted) {
      try {
        final _isSignedIn = await _userRepository.isSignedIn();
        if (_isSignedIn) {
          final user = await _userRepository.getUserFromDatabase();
          yield Authenticated(user: user);
        } else {
          //_userRepository.createUserIfNotExisitent();
          yield Unauthenticated();
        }
      } catch (err) {
        print("Error in Event App Started");
        print(err.toString());
        yield Unauthenticated();
      }
    } else if (event is LoggedIn) {
      yield Authenticated(user: await _userRepository.getUserFromDatabase());
    }
  }
}
