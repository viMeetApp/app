import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/search_tags/cubit/search_tag_cubit.dart';
import 'package:signup_app/search_tags/view/tag.dart';

class TagWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SearchTagCubit, SearchTagState>(
        //buildWhen: (previous, current)=>previous.isExpanded!=current.isExpanded,
        builder: (context,state){
          return Column(
            children: [
              ElevatedButton(onPressed: (){BlocProvider.of<SearchTagCubit>(context).toggleFold();}, child:Text("Press me") ),
              AnimatedContainer(
                height: state.height,
                duration: Duration(seconds: 1),
                child: Wrap(children: buildTags(state.tagMap),alignment: WrapAlignment.center,)),
            ],
          );
        },
    );
  }

  List<Widget> buildTags(Map<String, bool> tags){
    List<Widget> tagWidgets=[];
    tags.forEach((key, value) {tagWidgets.add(Tag(isActive: value,tagDescription: key,));});
    return tagWidgets;
  }

}

