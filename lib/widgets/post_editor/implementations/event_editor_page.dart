import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/post_editor/event_editor/cubit/event_editor_cubit.dart';
import 'package:signup_app/widgets/post_editor/event_editor/view/event_editor_form.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/cubit/tag_cubit.dart';

class CreateEventPage extends StatelessWidget {
  ///Set Group argument when post is Created out of Group
  static Route route({Group? group}) {
    return MaterialPageRoute<void>(
      builder: (_) => CreateEventPage(
        group: group,
      ),
    );
  }

  final Group? group;

  CreateEventPage({this.group});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventEditorCubit>(
            create: (_) => EventEditorCubit.newEvent(group: group)),
        BlocProvider<TagCubit>(create: (_) => TagCubit()),
      ],
      child: EventEditorForm(),
    );
  }
}
