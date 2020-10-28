import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:signup_app/util/data_models.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostState.empty());

  /// Document gets submitted
  /// !TODO Checks if all fields are filled out
  void submitted() async {
    emit(CreatePostState.loading());

    // !TODO implement the submitting of posts
  }

  void sendMessage(String content) {
    //Check If String is Valid For Example don't send Empty String
    /*if (content.length != 0 ?? content != null) {
      Post message =
          Message.createTextMessage(author: user, content: content);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('messages')
          .add(message.toJson());
    }*/
  }
}
