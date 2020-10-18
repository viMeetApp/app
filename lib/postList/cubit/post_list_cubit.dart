import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/util/DataModels.dart';


class PostListCubit extends Cubit<Stream<List<Post>>> {

  Stream<List<Post>> postStream;
  
  PostListCubit() : super(Stream.empty()){
    postStream=PostRepository().getPosts(null);
    emit(postStream);
  }
  
}
