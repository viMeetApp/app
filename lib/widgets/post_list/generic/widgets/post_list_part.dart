import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/post_list/generic/widgets/post_tile.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/post_list/implementations/filterable/cubit/post_list_cubit.dart';

///Shows List of all Posts matching criteria (filter)
///This is a more generic Class should not be used by Itself one should Only used the derived Classes
///filterablePostList and PlainPostist
class PostListPart extends StatelessWidget {
  final bool paddedTop;
  final bool highlight;
  PostListPart({this.paddedTop = false, this.highlight = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListFilterableCubit, PostListState>(
      //buildWhen: (prev, curr) => prev.postStream != curr.postStream,
      builder: (context, state) {
        return Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: StreamBuilder(
              stream: state.postStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var blocRef =
                      BlocProvider.of<PostListFilterableCubit>(context);
                  return ListView.builder(
                      reverse:
                          false, //Muss so rum stehen sons Liste von unten aus gefüllt -> Das heißt wir müssen selber alle Einträge umdrehen (noch zu machen)
                      itemCount: (snapshot.data! as List).length,
                      itemBuilder: (context, index) => CreationAwareWidget(
                          itemCreated: () {
                            if ((index + 1) % blocRef.paginationDistance == 0) {
                              blocRef.requestMore();
                            }
                          },
                          child: (paddedTop && index == 0)
                              ? Container(
                                  //color: AppThemeData.colorAccent,
                                  padding: EdgeInsets.only(top: 15),
                                  child: PostTile(
                                      post: (snapshot.data! as List)[index]))
                              : PostTile(
                                  post: (snapshot.data! as List)[index],
                                  highlight: highlight,
                                )));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
