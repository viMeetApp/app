import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/cubit/tag_cubit.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/view/tag.dart';

class TagWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagCubit, TagState>(builder: (context, state) {
      return Container(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: buildTags(state.tagMap),
        ),
      );
    });
  }
}

List<Widget> buildTags(Map<String, bool> tags) {
  List<Widget> tagWidgets = [
    SizedBox(
      width: 10,
    )
  ];
  tags.forEach((key, value) {
    tagWidgets.add(Tag(
      isActive: value,
      tagDescription: key,
    ));
  });
  return tagWidgets;
}
