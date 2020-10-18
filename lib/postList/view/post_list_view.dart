import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/postList/cubit/post_list_cubit.dart';
import 'package:signup_app/postList/view/post_tile.dart';
import 'package:signup_app/util/DataModels.dart';

class PostListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostListCubit(),
      child: BlocBuilder<PostListCubit, Stream<List<Post>>>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Top Search Bar
              TextField(),
              SizedBox(height:20),
              //Feed
              Expanded(
                
                child: StreamBuilder(
                
                  stream: state,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        reverse: false, //Muss so rum stehen sons Liste von unten aus gefüllt -> Das heißt wir müssen selber alle Einträge umdrehen (noch zu machen)
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) =>
                            PostTile(post: snapshot.data[index]),
                      );
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
