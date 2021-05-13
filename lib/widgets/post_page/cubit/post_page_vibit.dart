import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/repositories/post_interactions.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/vibit/vibit.dart';

class PostPageState extends ViState {
  final PostRepository _postRepository;
  final PostInteractions _postInteractions;

  bool expanded = false;
  bool favorited = false;
  bool subscribed = false;
  Post post;

  PostPageState(
      {required this.post,
      PostRepository? postRepository,
      AuthenticationService? authenticationService})
      : _postInteractions = PostInteractions(post: post),
        _postRepository = postRepository ?? PostRepository() {
    // Subscribe for updated about this post
    _postRepository.getPostStreamById(post.id).listen((Post? dbpost) {
      if (dbpost is Event) {
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

  Future<void> subscribe() {
    return _postInteractions.subscribe();
  }

  Future<void> unsubscribe() {
    return _postInteractions.unsubscribe();
  }
}
