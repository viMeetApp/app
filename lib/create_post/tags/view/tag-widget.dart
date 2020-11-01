import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/tags/cubit/tag_cubit.dart';
import 'package:signup_app/create_post/tags/view/tag.dart';

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
  List<Widget> tagWidgets = [];
  tags.forEach((key, value) {
    tagWidgets.add(Tag(
      isActive: value,
      tagDescription: key,
    ));
  });
  return tagWidgets;
}
