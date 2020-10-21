import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/util/data_models.dart';

//!To Do Implement Pagination aber davor vermutlich besser Suche
class PostListCubit extends Cubit<Stream<List<Post>>> {
  Stream<List<Post>> postStream;

  PostListCubit() : super(Stream.empty()) {
    postStream = PostRepository().getPosts(null);
    emit(postStream);
  }
}
