import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/authentication/bloc/authentication_bloc.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/util/data_models.dart';

part 'post_detailed_state.dart';

class PostdetailedCubit extends Cubit<PostDetailedState> {
  Post post;
  PostRepository _postRepository = PostRepository();

  PostdetailedCubit({@required this.post})
      : assert(post != null),
        super(Uninitialized()) {
    if (post.type == 'event') {
      emit(EventState(post: post));
    } else if (post.type == 'buddy') {
      emit(BuddyState());
    }
  }
  //ToDo Was passiert wenn wir hier einen Erro bekommen. Im Moment wird ja lokal und auf DB geupdated, da das so schneller ist. Sollen wir den emit state vielleciht erst.then()Methode bauen
  ///Subscribe to Post
  void subscribe() {
    if (state.post is Event) {
      (state.post as Event)
          .participants
          .add(FirebaseAuth.instance.currentUser.uid);
      emit((state as EventState).copyWith(post: state.post));
      _postRepository.updatePost(state.post).catchError((err) {
        print("There was an error unsubscribing");
      });
    }
  }

  ///Toggle if Top Card is Expanded
  void toggleExpanded() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  ///Fold in the Top Card
  void foldIn() {
    if (state.isExpanded) emit(state.copyWith(isExpanded: false));
  }

  //ToDo Was passiert wenn wir hier einen Erro bekommen. Im Moment wird ja lokal und auf DB geupdated, da das so schneller ist. Sollen wir den emit state vielleciht erst.then()Methode bauen
  ///Subscribe to Post
  void unsubscribe() {
    if (state.post is Event) {
      (state.post as Event).participants.remove(FirebaseAuth.instance
          .currentUser.uid); //? Could Get ID from User Repository maybe better
      emit((state as EventState).copyWith(post: state.post));
      _postRepository.updatePost(state.post).catchError((err) {
        print("There was an error unsubscribing");
      });
    }
  }

  ///Function to call if Favourite Icon in pressed
  ///At the Moment just toggles State
  void favourite() {
    emit(state.copyWith(isFavourite: !state.isFavourite));
  }
}
