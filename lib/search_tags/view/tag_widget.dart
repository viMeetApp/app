import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/search_tags/cubit/search_tag_cubit.dart';

class TagWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchTagCubit>(
      create: (_)=>SearchTagCubit(),
      child: BlocBuilder<SearchTagCubit, SearchTagState>(
        //buildWhen: (previous, current)=>previous.isExpanded!=current.isExpanded,
        builder: (context,state){
          return Column(
            children: [
              ElevatedButton(onPressed: (){BlocProvider.of<SearchTagCubit>(context).press();}, child:Text("Press me") ),
              AnimatedContainer(
                height: state.height,
                duration: Duration(seconds: 1),
                child: Wrap(children: buildTags(state.tagMap),alignment: WrapAlignment.center,)),
            ],
          );
        },
      ),
    ); 
  }

  List<Widget> buildTags(Map<String, bool> tags){
    List<Widget> tagWidgets=[];
    tags.forEach((key, value) {tagWidgets.add(Tag(isActive: value,tagDescription: key,));});
    return tagWidgets;
  }

}

class Tag extends StatelessWidget {
  final String tagDescription;
  final bool isActive;
  Tag({@required this.tagDescription, @required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(tagDescription,style:TextStyle(fontSize: 10)),);
  }
}