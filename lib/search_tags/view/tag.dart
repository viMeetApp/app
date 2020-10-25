import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/search_tags/cubit/search_tag_cubit.dart';

class Tag extends StatelessWidget {
  final String tagDescription;
  final bool isActive;
  Tag({@required this.tagDescription, @required this.isActive});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: 
      isActive?Chip(
        backgroundColor: Colors.green,
        label: Text(tagDescription, style: TextStyle(fontSize: 10)),
      ):
      Chip(
        backgroundColor: Colors.grey,
        label: Text(tagDescription, style: TextStyle(fontSize: 10)),
      ),
      onTap: (){
        BlocProvider.of<SearchTagCubit>(context).updateFilterTags(tagDescription);
      },
    );
  }
}
