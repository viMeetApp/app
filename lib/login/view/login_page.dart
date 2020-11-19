import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/login/cubit/login_cubit.dart';
import 'package:signup_app/login/view/login_form.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/presets.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(30),
              /*constraints: BoxConstraints(
                  maxHeight: 0.6 * MediaQuery.of(context).size.height),*/
              decoration: new BoxDecoration(
                  color: AppThemeData.colorPrimary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 20.0,
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: Text(
                      "Hallo!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 55,
                          color: AppThemeData.colorTextInverted,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Wie sollen dich anderen nennen?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        color: AppThemeData.colorTextInverted,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: BlocProvider<LoginCubit>(
                      create: (_) => LoginCubit(UserRepository()),
                      child: LoginForm(),
                    ),
                  ),
                ],
              ),
            )));
  }
}
