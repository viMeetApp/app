import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/search_tags/cubit/search_tag_cubit.dart';
import 'package:signup_app/widgets/search_tags/view/widgets/search_tag.dart';

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
              padding: EdgeInsets.all(state.isExpanded! ? 8 : 4),
              child: !state.isExpanded!
                  ? null
                  : LimitedBox(
                      //maxHeight: state.isExpanded ? double.infinity : 0,
                      child: Wrap(
                        children: buildTags(state.tagMap!),
                        alignment: WrapAlignment.center,
                      ),
                    ),
            ));
      },
    );
  }

  List<Widget> buildTags(Map<PostTag, bool> tags) {
    List<Widget> tagWidgets = [];
    tags.forEach((key, value) {
      tagWidgets.add(Tag(isActive: value, tag: key));
    });
    return tagWidgets;
  }
}
