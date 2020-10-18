import 'package:cloud_firestore/cloud_firestore.dart';

/// Author: Robin <constorux@gmail.com>

/// Object that holds information to a single user as saved in the database
///
/// [uid] links a network user to a Firebase-Authentication user
/// [name] name of the user that the user can set himself
class User {
  String name;
  String uid;
}

/// Object that holds information to a group as saved in the database
///
/// [name] Name of the group
/// [about] Text that informs about the group
/// [users] a list of the userIDs of the users that are in the group
class Group {
  String name;
  String about;
  List<String> users = [];
}

/// Object that holds information about a Post
///
/// [title] title of the post
/// [geohash] Geohash of where the Post was posted (.60km accuracy, 6 characters)
/// [tags] tags of the post
/// [about] text describing the post
/// [type] is the post an 'event' or an 'offer'
/// [createdDate] the date and time at which the post was created
/// [expireDate] the date and time when the post will expire
class Post {
  String title;
  String geohash;
  List<String> tags;
  String about;
  String type;
  int createdDate;
  int expireDate;

  ///Create Post from Firestore Snapahot [snap]
  Post.fromSnapshot(DocumentSnapshot snap):
  title= snap['title'], geohash= snap['geohash'], tags=snap['tags'].cast<String>(), about= snap['about'], type=snap['type'], createdDate=snap['createdDate'],expireDate=snap['expireDate'];

  ///Create Json Date to Store in Firestore
  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'geohash': geohash,
      'tags': tags,
      'about': about,
      'type': type,
      'createdDate': createdDate,
      'expireDate': expireDate
    };
  }
}


/// Object that holds information to a Message from a chat of a post
///
/// [author] user that composed the message
/// [timestamp] the time at which the post was composed
/// [type] indicates if the message is a text or a video message
/// [content] message of the user or reference to the video file
class Message {
  User author;
  int timestamp;
  String type;
  String content;
}

/// Post of the type Event
/// [eventDate] timeAndDate when the post will take place
/// [maxPeople] maximum number of people that can attend the event (-1 if unlimited)
/// [participants] current members of the event. List of User-IDs
/// [location] where the event will start
class Event extends Post{
  int eventDate;
  int maxPeople; 
  List<String> participants;
  String location;
  
  ///Create Event from Firestore Snapshot [snap]
  Event.fromSnapshot(DocumentSnapshot snap):
  eventDate=snap['eventDate'], maxPeople=snap['maxPeople'], participants=snap['participants'].cast<String>(), location=snap['location'], super.fromSnapshot(snap);

  ///Create Json Object to Store in Firestore
  Map<String,dynamic> toJson(){
    return{
      ...super.toJson(),
      'eventDate': eventDate,
      'maxPeople': maxPeople,
      'participants': participants,
      'location': location
    };
  }

}


/// Post of the type events
/// TODO: talk about needed fields
class Buddy extends Post{
  ///Create Buddy from a Firestore Snapshot [snap]
    Buddy.fromSnapshot(DocumentSnapshot snap):
    super.fromSnapshot(snap);

  ///Create Json Object to Store in Firestore
  Map<String,dynamic> toJson(){
    return{
      ...super.toJson(),
    };
  }
}
