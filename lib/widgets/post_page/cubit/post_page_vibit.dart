import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/vibit/vibit.dart';

class PostPageState extends ViState {
  bool expanded = true;
  bool favorited = false;
  bool subscribed = false;
  Post post;

  PostPageState(this.post);

  bool postIsExpired() {
    return post.expireDate! < DateTime.now().millisecondsSinceEpoch + 86400000;
  }

  /// returns whether the current user is the author of the post
  bool postIsOwned() {
    return post.author!.id == FirebaseAuth.instance.currentUser!.uid;
  }

  void toggleFavorite() {
    //TODO
  }

  void toggleExpanded() {
    expanded = !expanded;
    refresh();
  }

  void unsubscribe() {
    //TODO
    subscribed = false;
    refresh();
  }

  void subscribe() {
    //TODO
    subscribed = true;
    refresh();
  }
}
