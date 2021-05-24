import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/post_editor/event_editor/cubit/event_editor_cubit.dart';
import 'package:signup_app/widgets/post_editor/event_editor/view/event_editor_form.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/cubit/tag_cubit.dart';

class UpdatePostPage extends StatelessWidget {
  ///Set Group argument when post is Created out of Group
  static Route route({required Post post}) {
    return MaterialPageRoute<void>(
      builder: (_) => UpdatePostPage(
        post: post,
      ),
    );
  }

  final Post post;

  UpdatePostPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventEditorCubit>(
            create: (_) =>
                //(post is Event)?EventEditorCubit.fromGivenEvent(event: post as Event): ),
                //ToDo auskommentierte Version vervollständigen
                EventEditorCubit.fromGivenEvent(event: post as Event)),
        BlocProvider<TagCubit>(create: (_) => TagCubit(tags: post.tags)),
      ],
      child: EventEditorForm(),
    );
  }
}
