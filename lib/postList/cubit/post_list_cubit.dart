import 'package:bloc/bloc.dart';

import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/util/data_models.dart';

part 'post_list_state.dart';


//!To Do Implement Pagination aber davor vermutlich besser Suche
class PostListCubit extends Cubit<PostListState> {

  Stream<List<Post>> postStream;
  
  PostListCubit() : super(PostListState.initial()){
    postStream=PostRepository().getPostsFitlered(null);
    emit(state.copyWith(stream: postStream));
  }

  ///Update Filter with [tags]
  void updateFilter(List<String> tags){
     postStream=PostRepository().getPostsFitlered(tags);
     emit(state.copyWith(stream: postStream));
  }
}
