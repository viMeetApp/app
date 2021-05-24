import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/search_tags/cubit/search_tag_cubit.dart';

class Tag extends StatelessWidget {
  final PostTag tag;
  final bool isActive;
  Tag({required this.tag, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: isActive
            ? Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 4,
                backgroundColor: AppThemeData.colorPrimaryLight,
                label: Text(
                    ViLocalizations.of(context).postTag(enumToString(tag)),
                    style: TextStyle(
                        fontSize: 14, color: AppThemeData.colorTextInverted)),
              )
            : Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppThemeData.colorCard,
                label: Text(
                    ViLocalizations.of(context).postTag(enumToString(tag)),
                    style: TextStyle(fontSize: 14)),
              ),
      ),
      onTap: () {
        BlocProvider.of<SearchTagCubit>(context).updateFilterTags(tag);
      },
    );
  }
}
