import 'package:signup_app/repositories/pagination/post_pagination.dart';
import 'package:signup_app/services/geo_services/geo_locator.dart';
import 'package:signup_app/widgets/post_list/generic/post_list_controller.dart';

import '../../../../common.dart';

class PostListFilterableController extends PostListController {
  PostListFilterableController(
      {required Group? group, int paginationDistance = 20})
      : super(
            postPagination: PostPagination(
                group: group, paginationDistance: paginationDistance)) {
    GeoLocator().addCurrentPlaceListener((value) => postPagination.newQuery());
  }

  ///Update Filter with [tags]
  void updateFilter({List<PostTag> tags = const []}) async {
    postPagination.newQuery(tags: tags);
  }
}
