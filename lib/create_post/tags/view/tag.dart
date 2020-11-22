import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/tags/cubit/tag_cubit.dart';
import 'package:signup_app/util/presets.dart';

class Tag extends StatelessWidget {
  final String tagDescription;
  final bool isActive;
  Tag({@required this.tagDescription, @required this.isActive});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 5, top: 5),
        child: isActive
            ? Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: 4,
                backgroundColor: AppThemeData.colorCard,
                label: Text(tagDescription,
                    style: TextStyle(
                        fontSize: 14, color: AppThemeData.colorTextRegular)),
              )
            : Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppThemeData.colorPrimaryLighter,
                label: Text(tagDescription,
                    style: TextStyle(
                        fontSize: 14, color: AppThemeData.colorTextInverted)),
              ),
      ),
      onTap: () {
        BlocProvider.of<TagCubit>(context).updateTags(tagDescription);
      },
    );
  }
}
