import 'package:signup_app/util/models/data_models.dart';

abstract class PostListStateInterface {
  final Stream<List<Post>> postStream;

  PostListStateInterface({required this.postStream});
}
