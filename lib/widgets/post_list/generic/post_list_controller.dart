import 'package:signup_app/repositories/pagination/post_pagination.dart';

import '../../../common.dart';

class PostListController {
  final int paginationDistance;
  final PostPagination postPagination;
  late final Stream<List<Post>> postStream;

  PostListController(
      {required this.postPagination, this.paginationDistance = 20}) {
    postPagination.newQuery(tags: []);
    postStream = postPagination.postStreamController.stream;
  }

  void requestMore() {
    postPagination.requestPosts();
  }
}
