import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/search_tags/cubit/search_tag_cubit.dart';
import 'package:signup_app/util/presets.dart';

class Tag extends StatelessWidget {
  final String tagDescription;
  final bool isActive;
  Tag({@required this.tagDescription, @required this.isActive});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 1, bottom: 1),
        child: isActive
            ? Chip(
                backgroundColor: AppThemeData.colorPrimaryLight,
                label: Text(tagDescription, style: TextStyle(fontSize: 10)),
              )
            : Chip(
                backgroundColor: Colors.grey[400],
                label: Text(tagDescription, style: TextStyle(fontSize: 10)),
              ),
      ),
      onTap: () {
        BlocProvider.of<SearchTagCubit>(context)
            .updateFilterTags(tagDescription);
      },
    );
  }
}
