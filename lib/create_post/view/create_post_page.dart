import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/cubit/create_post_cubit.dart';
import 'package:signup_app/create_post/tags/cubit/tag_cubit.dart';
import 'package:signup_app/create_post/view/create_post_form.dart';
import 'package:signup_app/util/presets.dart';

class CreatePostPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreatePostPage());
  }

//Ich glaube das ist eine schöne Lösung um um alle Text Ediding Controller rumzukommen
//Eventuell ist es best Practise dieses Speichern im BLOC zu machen
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreatePostCubit>(
          create: (_) => CreatePostCubit(),
        ),
        BlocProvider<TagCubit>(create: (_) => TagCubit()),
      ],
      child: CreatePostForm(),
    );
  }
}
