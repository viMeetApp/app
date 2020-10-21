import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/authentication/bloc/authentication_bloc.dart';
import 'package:signup_app/util/data_models.dart';

part 'post_detailed_state.dart';

class PostdetailedCubit extends Cubit<PostDetailedState> {
  Post post;

  PostdetailedCubit({@required this.post})
      : assert(post != null),
        super(Uninitialized()) {
    if (post.type == 'event') {
      emit(EventState(post: post));
    } else if (post.type == 'buddy') {
      emit(BuddyState());
    }
  }

  ///Subscribe to Post
  void subscribe() {
    if (state.post is Event) {
      (state.post as Event).participants.add(FirebaseAuth.instance.currentUser
          .uid); //? Could Get ID from User Repository maybe better
      (state as EventState).copyWith(post: state.post);
    }
  }

  void favourite() {
    emit(state.copyWith(isFavourite: !state.isFavourite));
  }
}
