import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/cubit/create_post_cubit.dart';
import 'package:signup_app/create_post/view/create_post_form.dart';
import 'package:signup_app/util/Presets.dart';

class CreatePostPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreatePostPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppThemeData.colorCard),
          backgroundColor: AppThemeData.colorPrimaryLight,
          title: Text(
            "Neuen Post erstellen",
            style: TextStyle(color: AppThemeData.colorTextInverted),
          ),
        ),
        body: SafeArea(
          child: BlocProvider<CreatePostCubit>(
            create: (_) => CreatePostCubit(),
            child: CreatePostForm(),
          ),
        ));
  }
}
