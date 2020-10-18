import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/postList/cubit/post_list_cubit.dart';
import 'package:signup_app/postList/view/post_tile.dart';
import 'package:signup_app/util/DataModels.dart';
import 'package:signup_app/util/Presets.dart';

class PostListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => PostListCubit(),
        child: BlocBuilder<PostListCubit, Stream<List<Post>>>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Top Search Bar
                Container(
                  decoration: BoxDecoration(
                      color: AppThemeData().colorCard,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        decoration: new InputDecoration(
                            hintText: "Suche",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15)),
                      )),
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.filter_list),
                          onPressed: () => {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("TODO: Filter")))
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //Feed
                Expanded(
                  child: StreamBuilder(
                    stream: state,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          reverse:
                              false, //Muss so rum stehen sons Liste von unten aus gefüllt -> Das heißt wir müssen selber alle Einträge umdrehen (noch zu machen)
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
      ),
    );
  }
}
