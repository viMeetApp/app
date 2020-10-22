import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostState.empty());

  /// Document gets submitted
  /// !TODO Checks if all fields are filled out
  void submitted() async {
    emit(CreatePostState.loading());

    // !TODO implement the submitting of posts
  }
}
