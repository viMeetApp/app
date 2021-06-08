import 'package:flutter/material.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/widgets/post_list/generic/widgets/post_list_part.dart';
import 'package:signup_app/widgets/post_list/implementations/my_posts/post_list_my_posts_controller.dart';

class PostListMyPostsWidget extends StatelessWidget {
  PostListMyPostsWidget();
  @override
  Widget build(BuildContext context) {
    final postListController = PostListMyPostsController(
        user: AuthenticationService().getCurrentUserReference());
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PostListPart(
            paddedTop: true,
            postListController: postListController,
          ),
        ],
      ),
    );
  }
}
