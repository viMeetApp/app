import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/authentication/bloc/authentication_bloc.dart';
import 'package:signup_app/login/cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        //When Logged In -> Call Authetication Bloc with Logged in
        if (state.isLoggedIn) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
        //In Error Case or name invalid Show Error Snackbar
        else if (state.isError || !state.isNameValid) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('Authentication Failed'),
            ));
        }
        //Show is Loading Snackbar
        else if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('Logging in'),
            ));
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.isNameValid != current.isNameValid,
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'username',
                      errorText: !state.isNameValid
                          ? 'Bitte gibt einen Benutzername ein'
                          : null),
                ),
                RaisedButton(
                    onPressed: () {
                      BlocProvider.of<LoginCubit>(context)
                          .submitted(_nameController.text);
                    },
                    child: Text("Log In"))
              ],
            );
          }),
    );
  }
}
