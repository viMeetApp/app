/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/creation_aware_widget.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/widgets/post_list/baseClass/post_tile.dart';
import 'package:signup_app/widgets/post_list/cubit/post_list_cubit.dart';

///This List shows all Posts
///In addtition to the standard List is this List also filterable via Tags
class PlainPostList extends StatelessWidget {
  final Group group;
  final User user;
  PlainPostList({this.group, this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: BlocProvider(
        create: (context) => PostListCubit(group: group, user: user),
        child: BlocBuilder<PostListCubit, PostListState>(
          buildWhen: (prev, curr) => prev.postStream != curr.postStream,
          builder: (context, state) {
            return StreamBuilder(
              stream: state.postStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var blocRef = BlocProvider.of<PostListCubit>(context);
                  return ListView.builder(
                      reverse:
                          false, //Muss so rum stehen sons Liste von unten aus gefüllt -> Das heißt wir müssen selber alle Einträge umdrehen (noch zu machen)
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => CreationAwareWidget(
                          itemCreated: () {
                            if ((index + 1) % blocRef.paginationDistance == 0) {
                              blocRef.requestMore();
                            }
                          },
                          child: PostTile(post: snapshot.data[index])));
                }
              },
            );
          },
        ),
      ),
    );
  }
}*/
