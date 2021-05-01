import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/vibit/vibit.dart';

class PostPageState extends ViState {
  PostRepository _postRepository = new PostRepository();
  AuthenticationService _authService;

  bool expanded = false;
  bool favorited = false;
  bool subscribed = false;
  bool processing = false;
  Post post = Post.empty();

  PostPageState(
      {required String postId,
      PostRepository? postRepository,
      AuthenticationService? authenticationService})
      : _postRepository = postRepository ?? PostRepository(),
        _authService = authenticationService ?? AuthenticationService() {
    _postRepository.getPostStreamById(postId).listen((Post? dbpost) {
      if (dbpost is Event) {
        processing = false;
        post = dbpost;
        subscribed =
            dbpost.isMember(AuthenticationService().getCurrentUser().id);
        refresh();
      } else {
        //emit(BuddyState(post: post!));
      }
    });
  }

  bool postIsExpired() {
    return post.expiresAt < DateTime.now().millisecondsSinceEpoch;
  }

  /// returns whether the current user is the author of the post
  bool postIsOwned() {
    return post.author.id == FirebaseAuth.instance.currentUser!.uid;
  }

  void toggleFavorite() {
    //TODO
    favorited = !favorited;
    refresh();
  }

  void toggleExpanded() {
    expanded = !expanded;
    refresh();
  }

  void foldIn() {
    if (expanded) toggleExpanded();
  }

  //TODO Move this to the repository

  FirebaseFunctions functions = FirebaseFunctions.instance;

  ///Subscribe to Post by Calling the Cloud Function
  ///
  ///Ablauf: Cloud Function wird gecallt checkt ob man sich anmelden kann, Wenn ja verändert es den Eintrag in der Datenbank
  ///Anschließend sollte Post von selbst geupdated werden wegen snapshot
  Future<void> subscribe() async {
    processing = true;
    refresh();
    HttpsCallable callable = functions.httpsCallable(
      'posts-subscribeToPost',
    );
    try {
      await callable.call(
        post.id,
      );
      processing = false;
    } catch (err) {
      processing = false;
      refresh();
      print("There was an error subscribing" + err.toString());
    }
  }

  ///Unsubscribe from Post by Calling the Cloud Function
  ///
  ///Ablauf: Cloud Function wird gecallt checkt ob man sich anmelden kann, Wenn ja verändert es den Eintrag in der Datenbank
  ///Anschließend sollte Post von selbst geupdated werden wegen snapshot
  Future<void> unsubscribe() async {
    processing = true;
    refresh();
    HttpsCallable callable = functions.httpsCallable(
      'posts-unsubscribeFromPost',
    );
    try {
      await callable.call(
        post.id,
      );
      processing = false;
    } catch (err) {
      processing = false;
      refresh();
      print("There was an error unsubscribing" + err.toString());
    }
  }
}
