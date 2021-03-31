import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/post_editor/cubit/post_editor_cubit.dart';
import 'package:signup_app/widgets/post_editor/view/post_editor_form.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/cubit/tag_cubit.dart';

class CreatePostPage extends StatelessWidget {
  ///Set Group argument when post is Created out of Group
  static Route route({Group? group}) {
    return MaterialPageRoute<void>(
        builder: (_) => CreatePostPage(group: group));
  }

  final Group? group;
  CreatePostPage({required this.group});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostEditorCubit>(
            create: (_) => PostEditorCubit.createNewPost(group: group)),
        BlocProvider<TagCubit>(create: (_) => TagCubit()),
      ],
      child: CreatePostForm(),
    );
  }
}
