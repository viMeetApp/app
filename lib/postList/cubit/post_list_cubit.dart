import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/repositories/post_pagination.dart';

import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/util/data_models.dart';

part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  StreamController<List<Post>> streamController = StreamController();
  final int paginationDistance = 20;
  Group group;
  PostPagination postPagination;
  PostListCubit({this.group}) : super(PostListState.initial()) {
    postPagination = PostPagination(paginationDistance: paginationDistance);
    //postStream = PostRepository().getPostsFiltered(tags: null, group: group);
    postPagination.newQuery(tags: null, group: group);
    streamController.addStream(postPagination.postStreamController.stream);
    emit(PostListState(postStream: streamController.stream));
    //emit(state.copyWith(stream: postStream));
  }

  void requestMore() {
    postPagination.requestPosts();
  }

  ///Update Filter with [tags]
  void updateFilter(List<String> tags) async {
    postPagination.newQuery(tags: tags, group: group);

    emit(PostListState(postStream: streamController.stream));
  }
}
