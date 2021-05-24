import 'package:signup_app/common.dart';

abstract class PostListStateInterface {
  final Stream<List<Post>> postStream;

  PostListStateInterface({required this.postStream});
}
