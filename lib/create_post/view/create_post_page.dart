import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/cubit/create_post_cubit.dart';
import 'package:signup_app/create_post/tags/cubit/tag_cubit.dart';
import 'package:signup_app/create_post/view/create_post_form.dart';
import 'package:signup_app/util/data_models.dart';

class CreatePostPage extends StatelessWidget {
  ///Set Group argument when post is Created out of Group
  static Route route({Group group}) {
    return MaterialPageRoute<void>(
        builder: (_) => CreatePostPage()..group = group);
  }

  Group group;

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
      child: CreatePostForm(
        group: group,
      ),
    );
  }
}
