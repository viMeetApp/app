import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:signup_app/repositories/post_pagination.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/debug_tools.dart';

part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  //StreamController<List<Post>> streamController = StreamController();
  final int paginationDistance = 20;
  Group group;
  User user;
  PostPagination postPagination;
  PostListCubit({this.group, this.user}) : super(PostListState.initial()) {
    postPagination = PostPagination(
        paginationDistance: paginationDistance, group: group, user: user);
    //postStream = PostRepository().getPostsFiltered(tags: null, group: group);
    postPagination.newQuery(tags: null);
    //streamController.addStream(postPagination.postStreamController.stream);
    emit(PostListState(postStream: postPagination.postStreamController.stream));
    //emit(state.copyWith(stream: postStream));
  }

  void requestMore() {
    postPagination.requestPosts();
  }

  ///Update Filter with [tags]
  void updateFilter(List<String> tags) async {
    print('update filter');
    postPagination.newQuery(tags: tags);

    //emit(PostListState(postStream: streamController.stream));
  }
}
