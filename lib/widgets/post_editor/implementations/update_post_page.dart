import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/widgets/post_editor/cubit/post_editor_cubit.dart';
import 'package:signup_app/widgets/post_editor/view/post_editor_form.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/cubit/tag_cubit.dart';

class UpdatePostPage extends StatelessWidget {
  static Route route({Post post}) {
    return MaterialPageRoute<void>(builder: (_) => UpdatePostPage(post: post));
  }

  final Post post;
  UpdatePostPage({@required this.post});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostEditorCubit>(
            create: (_) => PostEditorCubit.updatePost(post: post)),
        BlocProvider<TagCubit>(create: (_) => TagCubit(tags: post.tags)),
      ],
      child: CreatePostForm(),
    );
  }
}
