import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/services/authentication/cubit/authentication_cubit.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/login/cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        //When Logged In -> Call Authetication Bloc with Logged in
        if (state.isLoggedIn) {
          BlocProvider.of<AuthenticationCubit>(context).loggedIn();
        }
        //In Error Case or name invalid Show Error Snackbar
        else if (state.isError || !state.isNameValid) {
          Tools.showSnackbar(context, "Authentication Failed");
        }
        //Show is Loading Snackbar
        else if (state.isSubmitting) {
          Tools.showSnackbar(context, "Logging in");
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.isNameValid != current.isNameValid,
          builder: (context, state) {
            return TextField(
              autocorrect: false,
              enableSuggestions: false,
              style: TextStyle(
                  fontSize: 18,
                  color: AppThemeData.colorTextInverted,
                  fontWeight: FontWeight.bold),
              controller: _nameController,
              decoration: Presets.getTextFieldDecorationHintStyle(
                hintText: "Name",
                errorText:
                    (!state.isNameValid ? 'Bitte gib einen Namen ein' : null),
                fillColor: AppThemeData.colorPrimaryLight,
                hintStyle: TextStyle(
                    color: AppThemeData.colorTextInverted,
                    fontWeight: FontWeight.normal),
                errorStyle: TextStyle(
                    color: AppThemeData.colorTextInverted,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(right: 9),
                  icon: Icon(
                    Icons.check,
                    color: AppThemeData.colorTextInverted,
                    size: 30,
                  ),
                  onPressed: () {
                    BlocProvider.of<LoginCubit>(context)
                        .submitted(_nameController.text);
                  },
                ),
              ),
            );
          }),
    );
  }
}
