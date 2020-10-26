import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/search_tags/cubit/search_tag_cubit.dart';
import 'package:signup_app/search_tags/view/tag.dart';

class TagWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTagCubit, SearchTagState>(
      //buildWhen: (previous, current)=>previous.isExpanded!=current.isExpanded,
      builder: (context, state) {
        return AnimatedSize(
            alignment: Alignment.bottomLeft,
            vsync: Scaffold.of(context),
            duration: Duration(milliseconds: 250),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: LimitedBox(
                maxHeight: state.isExpanded ? double.infinity : 0,
                child: Wrap(
                  children: buildTags(state.tagMap),
                  alignment: WrapAlignment.center,
                ),
              ),
            ));
      },
    );
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
}
