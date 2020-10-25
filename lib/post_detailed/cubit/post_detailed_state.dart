part of 'post_detailed_cubit.dart';

///State for the Detail Screen
///[isFavourite] True if user liked this Event -> heart is active
///[isSubscribed] True if user added this Event to his Events
///[canSubsribe] True if there is a free place in the Post
@immutable
class PostDetailedState {
  Post post;
  bool isFavourite;
  bool isExpanded = true;
  bool showPostVerlaengern = false;

  //Empty Constructor
  PostDetailedState.empty()
      : post = null,
        isFavourite = false,
        showPostVerlaengern = null,
        isExpanded=true;

  PostDetailedState({@required this.post, this.isFavourite, this.isExpanded}) {
    //Diese Werte kann man nacher dynamisch bei erzeugung berechnen
    this.isFavourite=this.isFavourite!=null?this.isFavourite:false;
    this.isExpanded=this.isExpanded!=null?this.isExpanded:true;

    if (post.expireDate < DateTime.now().millisecondsSinceEpoch + 86400000)
      showPostVerlaengern = true;
  }

  PostDetailedState copyWith({
    Post post,
    bool isFavourite,
    bool isExpanded,
  }) {
    return PostDetailedState(
      post: post ?? this.post,
      isFavourite: isFavourite ?? this.isFavourite,
      isExpanded: isExpanded??this.isExpanded,
    );
  }
}

class Uninitialized extends PostDetailedState {
  Uninitialized() : super.empty();
}

///State in which Screen is if Post is an Event
class EventState extends PostDetailedState {
  bool isSubscribed;
  bool canSubscribe;

  EventState({@required Post post, bool isFavourite, bool isExpanded})
      : super(post: post, isFavourite: isFavourite,isExpanded: isExpanded) {
    if ((post as Event)
        .participants
        .contains(FirebaseAuth.instance.currentUser.uid)) {
      isSubscribed = true;
      canSubscribe = false;
      print("subscribed");
    } else {
      isSubscribed = false;
      print("not subscribed");
      canSubscribe =
          (post as Event).participants.length < (post as Event).maxPeople;
    }
  }

  EventState copyWith({
    Post post,
    bool isFavourite,
    bool isExpanded
  }) {
    return EventState(
        post: post ?? this.post, isFavourite: isFavourite ?? this.isFavourite, isExpanded:isExpanded??this.isExpanded);
  }
}


///State in which Screen is if Post is a Buddy Post
class BuddyState extends PostDetailedState {}
