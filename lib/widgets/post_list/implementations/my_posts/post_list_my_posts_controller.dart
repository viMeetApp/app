import 'package:signup_app/repositories/pagination/post_pagination.dart';
import 'package:signup_app/widgets/post_list/generic/post_list_controller.dart';

import '../../../../common.dart';

class PostListMyPostsController extends PostListController {
  PostListMyPostsController(
      {required UserReference user, int paginationDistance = 20})
      : super(
          postPagination: PostPagination(
              user: user, paginationDistance: paginationDistance),
        );
}
