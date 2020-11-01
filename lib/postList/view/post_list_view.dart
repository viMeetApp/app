import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/postList/cubit/post_list_cubit.dart';
import 'package:signup_app/postList/view/post_tile.dart';
import 'package:signup_app/search_tags/cubit/search_tag_cubit.dart';
import 'package:signup_app/search_tags/view/tag_widget.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class PostListView extends StatelessWidget {
  Group group;
  PostListView({this.group});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppThemeData.varPaddingEdges),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<PostListCubit>(
              create: (context) => PostListCubit(group: group),
            ),
            BlocProvider<SearchTagCubit>(
              create: (context) => SearchTagCubit(),
            )
          ],
          child: BlocListener<SearchTagCubit, SearchTagState>(
              listener: (context, state) {
                print("listen");
                List<String> tagList = [];
                state.tagMap.forEach(
                  (key, value) {
                    if (value == true) tagList.add(key);
                  },
                );
                BlocProvider.of<PostListCubit>(context).updateFilter(tagList);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Top Search Bar
                  Container(
                    decoration: BoxDecoration(
                        color: AppThemeData.colorCard,
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
                            onPressed: () {
                              BlocProvider.of<SearchTagCubit>(context)
                                  .toggleFold();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  TagWidget(),
                  SizedBox(height: 20),
                  BlocBuilder<PostListCubit, PostListState>(
                    buildWhen: (prev, curr) =>
                        prev.postStream != curr.postStream,
                    builder: (context, state) {
                      return Expanded(
                        child: StreamBuilder(
                          stream: state.postStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
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
                      );
                    },
                  )
                ],
              ))),
    );
  }
}
