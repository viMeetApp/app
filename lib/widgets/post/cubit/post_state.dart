part of 'post_cubit.dart';

///State for the Detail Screen
///[isFavourite] True if user liked this Event -> heart is active
///[isSubscribed] True if user added this Event to his Events
///[canSubsribe] True if there is a free place in the Post
@immutable
class PostState {
  final Post post;
  final bool isFavourite;
  final bool isExpanded;
  final bool showPostVerlaengern;
  final bool isAuthor;

  //Empty Constructor
  PostState.empty()
      : post = null,
        isFavourite = false,
        showPostVerlaengern = null,
        isExpanded = true,
        isAuthor = false;

  PostState({@required this.post, isFavourite, isExpanded})
      : this.isFavourite = isFavourite != null ? isFavourite : false,
        this.isExpanded = isExpanded != null ? isExpanded : true,
        this.showPostVerlaengern = checkIfExpired(post),
        this.isAuthor = checkIfAuthor(post);

  PostState copyWith({
    Post post,
    bool isFavourite,
    bool isExpanded,
  }) {
    return PostState(
      post: post ?? this.post,
      isFavourite: isFavourite ?? this.isFavourite,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  static bool checkIfExpired(Post post) {
    return post.expireDate < DateTime.now().millisecondsSinceEpoch + 86400000;
  }

  static bool checkIfAuthor(Post post) {
    return post.author.id == FirebaseAuth.instance.currentUser.uid;
  }
}

class Uninitialized extends PostState {
  Uninitialized() : super.empty();
}

///State in which Screen is if Post is an Event
class EventState extends PostState {
  final bool isSubscribed;
  final bool canSubscribe;

  EventState({@required Post post, bool isFavourite, bool isExpanded})
      : isSubscribed = _checkIfSubscribed(post),
        canSubscribe = _checkIfSubscribed(post),
        super(post: post, isFavourite: isFavourite, isExpanded: isExpanded);

  EventState copyWith({Post post, bool isFavourite, bool isExpanded}) {
    return EventState(
        post: post ?? this.post,
        isFavourite: isFavourite ?? this.isFavourite,
        isExpanded: isExpanded ?? this.isExpanded);
  }

  static bool _checkIfSubscribed(Post post) {
    return (post as Event)
        .participants
        .contains(FirebaseAuth.instance.currentUser.uid);
  }

  static bool _checkIfCanSubscribe(Post post) {
    if (_checkIfSubscribed(post)) return false;
    return (post as Event).maxPeople == -1 ||
        (post as Event).participants.length < (post as Event).maxPeople;
  }
}

///State in which Screen is if Post is a Buddy Post
class BuddyState extends PostState {
  BuddyState({@required Post post}) : super(post: post);
}
