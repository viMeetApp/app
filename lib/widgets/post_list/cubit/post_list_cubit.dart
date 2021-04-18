import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/repositories/pagination/post_pagination.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/services/geo_services/geo_locator.dart';
import 'package:signup_app/util/models/data_models.dart';

part 'post_list_state.dart';

class PostListCubit extends Cubit<PostListState> {
  //StreamController<List<Post>> streamController = StreamController();
  final int paginationDistance = 20;
  Group? group;
  User? user;
  late PostPagination postPagination;
  PostListCubit({this.group, this.user}) : super(PostListState.initial()) {
    postPagination = PostPagination(
        paginationDistance: paginationDistance, group: group, user: user);
    postPagination.newQuery(tags: null);
    _listenForChanges();
    emit(PostListState(postStream: postPagination.postStreamController.stream));
  }

  void requestMore() {
    postPagination.requestPosts();
  }

  ///Update Filter with [tags]
  void updateFilter(List<String?> tags) async {
    postPagination.newQuery(tags: tags);
  }

  void _listenForChanges() {
    GeoLocator().addCurrentPlaceListener((value) => postPagination.newQuery());
  }
}
