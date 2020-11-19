import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/presets.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'home/home.dart';
import 'login/login.dart';
import 'splash/splash.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(AppThemeData.uiOverlayStyle);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(userRepository: UserRepository())
        ..add(AppStarted()),
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //! Checked Mode Flag is disabled
      debugShowCheckedModeBanner: false,
      theme: AppThemeData().materialTheme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            // directing to the home screen and passing the current authentication state
            _navigator.pushAndRemoveUntil<void>(
              HomePage.route(loggedIn: (state is Authenticated) ? true : false),
              (route) => false,
            );

            /*if (state is Authenticated) {
              
              _navigator.pushAndRemoveUntil<void>(
                HomePage.route(loggedIn: true),
                (route) => false,
              );
            } else if (state is Unauthenticated) {
              print("Unautheticated");
              _navigator.pushAndRemoveUntil<void>(
                HomePage.route(loggedIn: false),
                (route) => false,
              );
            } else {
              print("Error: Undefined State");
            }*/
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
