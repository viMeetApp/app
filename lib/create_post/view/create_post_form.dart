import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/cubit/create_post_cubit.dart';
import 'package:signup_app/util/Presets.dart';

class CreatePostForm extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: (context, state) {
        //When Logged In -> Call Authetication Bloc with Logged in
        if (state.isSubmitted) {
          // !TODO navigate to the next screen
        }
        //In Error Case or name invalid Show Error Snackbar
        else if (state.isError) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('Bitte alle Felder ausfüllen'),
            ));
        }
        //Show is Loading Snackbar
        else if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('wird veröffentlicht'),
            ));
        }
      },
      child: BlocBuilder<CreatePostCubit, CreatePostState>(
          buildWhen: (previous, current) => previous.isError != current.isError,
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: AppThemeData.colorPrimaryLight,
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration:
                            Presets.getTextFieldDecoration(hintText: "Titel"),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            controller: _nameController,
                            decoration: Presets.getTextFieldDecoration(
                                hintText: "Title"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            controller: _nameController,
                            decoration: Presets.getTextFieldDecoration(
                                hintText: "Title"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextField(
                            controller: _nameController,
                            decoration: Presets.getTextFieldDecoration(
                                hintText: "Title"),
                          ),
                        ),
                      ],
                    )),
                IconButton(
                  splashColor: AppThemeData.colorPrimary,
                  onPressed: () {
                    BlocProvider.of<CreatePostCubit>(context).submitted();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
