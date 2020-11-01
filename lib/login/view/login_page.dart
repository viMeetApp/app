import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/login/cubit/login_cubit.dart';
import 'package:signup_app/login/view/login_form.dart';
import 'package:signup_app/repositories/user_repository.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: SafeArea(
          child: BlocProvider<LoginCubit>(
            create: (_) => LoginCubit(UserRepository()),
            child: LoginForm(),
          ),
        ));
  }
}
