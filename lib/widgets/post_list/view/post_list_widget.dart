import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/post_list/cubit/post_list_cubit.dart';
import 'package:signup_app/widgets/post_list/post_list.dart';
import 'package:signup_app/widgets/search_tags/cubit/search_tag_cubit.dart';
import 'package:signup_app/widgets/search_tags/view/search_tags_widget.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

///This List shows all Posts
///In addtition to the standard List is this List also filterable via Tags
class PostList extends StatelessWidget {
  final Group group;
  final User user;
  final bool filterable;
  PostList({this.filterable = false, this.group, this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PostListCubit>(
            create: (context) => PostListCubit(group: group, user: user),
          ),
          BlocProvider<SearchTagCubit>(
            create: (context) => SearchTagCubit(),
          )
        ],
        child: BlocListener<SearchTagCubit, SearchTagState>(
          listener: (context, state) {
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
                child: filterable
                    ? Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppThemeData.colorCard,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
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
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15)),
                                  ),
                                ),
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
                        ],
                      )
                    : null,
              ),
              //SizedBox(height: filterable ? 20 : 0),
              PostListPart(
                paddedTop: filterable,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
