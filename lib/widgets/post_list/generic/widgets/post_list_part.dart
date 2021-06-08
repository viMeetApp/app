import 'package:flutter/material.dart';
import 'package:signup_app/widgets/post_list/generic/post_list_controller.dart';
import 'package:signup_app/widgets/post_list/generic/widgets/post_tile.dart';
import 'package:signup_app/common.dart';

///Shows List of all Posts matching criteria (filter)
///This is a more generic Class should not be used by Itself one should Only used the derived Classes
///filterablePostList and PlainPostist
class PostListPart extends StatelessWidget {
  final bool paddedTop;
  final PostListController postListController;
  final bool viewIsWithinGroupPage;
  PostListPart(
      {this.paddedTop = false,
      required this.postListController,
      this.viewIsWithinGroupPage = false});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: StreamBuilder(
          stream: postListController.postStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                reverse:
                    false, //Muss so rum stehen sons Liste von unten aus gefüllt -> Das heißt wir müssen selber alle Einträge umdrehen (noch zu machen)
                itemCount: (snapshot.data! as List).length,
                itemBuilder: (context, index) => CreationAwareWidget(
                  itemCreated: () {
                    if ((index + 1) % postListController.paginationDistance ==
                        0) {
                      postListController.requestMore();
                    }
                  },
                  child: (paddedTop && index == 0)
                      ? Container(
                          //color: AppThemeData.colorAccent,
                          padding: EdgeInsets.only(top: 15),
                          child: PostTile(
                            post: (snapshot.data! as List)[index],
                            canHighlight: !viewIsWithinGroupPage,
                          ),
                        )
                      : PostTile(
                          post: (snapshot.data! as List)[index],
                          canHighlight: !viewIsWithinGroupPage,
                        ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
