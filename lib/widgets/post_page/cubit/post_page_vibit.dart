import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/vibit/vibit.dart';

class PostPageState extends ViState {
  PostRepository _postRepository = new PostRepository();

  bool expanded = true;
  bool favorited = false;
  bool subscribed = false;
  bool processing = false;
  Post post = Post();

  PostPageState(String postID) {
    _postRepository.getPostStreamById(postID).listen((Post? dbpost) {
      if (dbpost is Event) {
        processing = false;
        post = dbpost;
        subscribed =
            (dbpost.participants?.contains(UserRepository().getUser()?.id) ??
                false);
        refresh();
      } else {
        //emit(BuddyState(post: post!));
      }
    });
  }

  bool postIsExpired() {
    return post.expireDate < DateTime.now().millisecondsSinceEpoch + 86400000;
  }

  /// returns whether the current user is the author of the post
  bool postIsOwned() {
    return post.author?.id == FirebaseAuth.instance.currentUser!.uid;
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
  void subscribe() {
    processing = true;
    refresh();
    HttpsCallable callable = functions.httpsCallable(
      'subscribeToPost',
    );
    callable.call(<String, dynamic>{'postId': post.id}).then((value) {
      print("Unsubscribed Sucessfully");
      processing = false;
      //refresh();
    }).onError((err, trace) {
      processing = false;
      refresh();
      print("There was an error subscribing" + err.toString());
    });
  }

  ///Unsubscribe from Post by Calling the Cloud Function
  ///
  ///Ablauf: Cloud Function wird gecallt checkt ob man sich anmelden kann, Wenn ja verändert es den Eintrag in der Datenbank
  ///Anschließend sollte Post von selbst geupdated werden wegen snapshot
  void unsubscribe() {
    processing = true;
    refresh();
    HttpsCallable callable = functions.httpsCallable(
      'unsubscribeFromPost',
    );
    callable.call(<String, dynamic>{'postId': post.id}).then((value) {
      print("Unsubscribed Sucessfully");
      processing = false;
      //refresh();
    }).onError((err, trace) {
      processing = false;
      refresh();
      print("There was an error unsubscribing" + err.toString());
    });
  }
}
