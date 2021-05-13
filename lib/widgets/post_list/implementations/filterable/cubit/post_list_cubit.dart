import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:signup_app/repositories/pagination/post_pagination.dart';
import 'package:signup_app/services/geo_services/geo_locator.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/post_list/generic/post_list_state_interface.dart';

part 'post_list_state.dart';

class PostListFilterableCubit extends Cubit<PostListState> {
  //StreamController<List<Post>> streamController = StreamController();
  final int paginationDistance = 20;
  Group? group;
  late PostPagination postPagination;
  PostListFilterableCubit({this.group}) : super(PostListState.initial()) {
    postPagination =
        PostPagination(paginationDistance: paginationDistance, group: group);
    postPagination.newQuery(tags: []);
    _listenForChanges();
    emit(PostListState(postStream: postPagination.postStreamController.stream));
  }

  void requestMore() {
    postPagination.requestPosts();
  }

  ///Update Filter with [tags]
  void updateFilter({List<PostTag> tags = const []}) async {
    postPagination.newQuery(tags: tags);
  }

  void _listenForChanges() {
    GeoLocator().addCurrentPlaceListener((value) => postPagination.newQuery());
  }
}
