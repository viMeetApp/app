import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:authentication_repository/authentication_repository.dart';





part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  AuthenticationBloc({AuthenticationRepository authenticationRepository}) :assert(authenticationRepository!=null),
  _authenticationRepository=authenticationRepository, 
  super(Uninitilaized());


  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is AppStarted){
      try{
        final _isSignedIn=_authenticationRepository.isSignedIn();
        if(_isSignedIn){
          final user=await _authenticationRepository.getUser();
          yield Authenticated(user: user);
        }
        else {
          yield Unauthenticated();
        }
      }
      catch(err){
        print("Error in Event App Started");
        print(err.toString());
        yield Unauthenticated();
      }
    }

    else if (event is LoggedIn){
      yield Authenticated(user: await _authenticationRepository.getUser());
    }
  }
}
