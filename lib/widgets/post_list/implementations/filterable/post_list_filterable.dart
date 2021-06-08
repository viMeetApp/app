import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/post_list/generic/widgets/post_list_part.dart';
import 'package:signup_app/widgets/post_list/implementations/filterable/post_list_filterable_controller.dart';
import 'package:signup_app/widgets/search_tags/cubit/search_tag_cubit.dart';
import 'package:signup_app/widgets/search_tags/view/search_tags_widget.dart';

class PostListFilterableWidget extends StatelessWidget {
  final Group? group;
  PostListFilterableWidget({this.group});

  @override
  Widget build(BuildContext context) {
    final postListController = PostListFilterableController(group: group);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SearchTagCubit>(
            create: (context) => SearchTagCubit(),
          )
        ],
        child: BlocListener<SearchTagCubit, SearchTagState>(
          listener: (context, state) {
            List<PostTag> tagList = [];
            state.tagMap!.forEach(
              (key, value) {
                if (value == true) tagList.add(key);
              },
            );
            postListController.updateFilter(tags: tagList);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Top Search Bar
              Container(
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppThemeData.colorCard,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
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
              )),
              //SizedBox(height: filterable ? 20 : 0),
              PostListPart(
                paddedTop: true,
                postListController: postListController,
                viewIsWithinGroupPage: group != null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
