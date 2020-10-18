part of 'post_detailed_cubit.dart';

///State for the Detail Screen
///[isFavourite] True if user liked this Event -> heart is active
///[isSubscribed] True if user added this Event to his Events
///[canSubsribe] True if there is a free place in the Post
@immutable
class PostDetailedState {
  Post post;
  bool isFavourite;
  bool showPostVerlaengern=false;
  PostDetailedState.empty():post=null, isFavourite=false,showPostVerlaengern=null;

  PostDetailedState({@required this.post, this.isFavourite}){
    if(this.isFavourite==null) this.isFavourite=false;//Im Moment muss später von Firebase geladen werden
    //Hard gecodet warnt 1 Tag vor ablauf
   
   if(post.expireDate < DateTime.now().millisecondsSinceEpoch+86400000) showPostVerlaengern=true;
  }

  PostDetailedState copyWith({
    Post post,
    bool isFavourite,
  }){
    return PostDetailedState(post: post??this.post,
    isFavourite:isFavourite??this.isFavourite,
    );
  }
}

class Uninitialized extends PostDetailedState{
  Uninitialized():super.empty();
}

class EventState extends PostDetailedState{
  bool isSubscribed;
  bool canSubscribe;

  EventState({@required Post post, bool isFavourite}):super(post: post, isFavourite: isFavourite){
    if((post as Event).participants.contains(FirebaseAuth.instance.currentUser.uid)){
      isSubscribed=true;
      canSubscribe=false;
    }
    else{
      isSubscribed=false;
      canSubscribe=(post as Event).participants.length<(post as Event).maxPeople;
    }
  }

  EventState copyWith({
    Post post,
    bool isFavourite,

  }){
    return EventState(post: post??this.post,isFavourite: isFavourite??this.isFavourite);
  }
}

class BuddyState extends PostDetailedState{}


