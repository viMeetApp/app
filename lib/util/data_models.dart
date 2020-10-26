import 'package:flutter/foundation.dart';

/// Author: Robin <constorux@gmail.com>

/// Object that holds information to a single user as saved in the database
///
/// [uid] links a network user to a Firebase-Authentication user
/// [name] name of the user that the user can set himself
class User {
  String name;
  String uid;

  User.fromJson(var data)
      : name = data['name'],
        uid = data['uid'];

  User({@required this.name, @required this.uid});

  Map<String, dynamic> toJson() {
    return {'name': name, 'uid': uid};
  }
}

/// Class that defines Objects that are created by a user
///
///  [author] the author of the Object
class UserGeneratedContent {
  User author;
}

/// Database Object that includes an id
///
///  [id] the author of the Object in the database
class DatabaseDocument {
  String id;
}

/// Object that holds information to a group as saved in the database
///
/// [name] Name of the group
/// [about] Text that informs about the group
/// [users] a list of the userIDs of the users that are in the group
class Group implements DatabaseDocument {
  String name;
  String about;
  List<String> users = [];

  @override
  String id;

  ///Create Group from Firestore Snapahot [data]
  Group.fromJson(var data, String id)
      : name = data['name'],
        about = data['about'],
        users = data['users'].cast<String>(),
        id = id;
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
/// [groupID] id of the group the post was posted in. (Optional)
class Post implements UserGeneratedContent, DatabaseDocument {
  String title;
  String geohash;
  List<String> tags = [];
  String about;
  String type;
  int createdDate;
  int expireDate;
  String groupID;

  @override
  User author;

  @override
  String id;

  ///Create Post from Firestore Snapahot [data]
  Post.fromJson(var data, String id)
      : title = data['title'],
        geohash = data['geohash'],
        about = data['about'],
        type = data['type'],
        createdDate = data['createdDate'],
        expireDate = data['expireDate'],
        this.id = id {
    data['tags'].forEach((key, value) {
      if (value == true) tags.add(key);
    });
  }

  ///Create Json Date to Store in Firestore
  Map<String, dynamic> toJson() {
    Map<String, bool> tagMap = new Map();
    tags.forEach((element) {
      tagMap.addEntries([MapEntry(element, true)]);
    });
    return {
      'title': title,
      'geohash': geohash,
      'tags': tagMap,
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
class Message implements UserGeneratedContent {
  int timestamp;
  String type;
  String content;

  @override
  User author;

  Message.fromJson(var data)
      : author = User.fromJson(data['author']),
        timestamp = data['timestamp'],
        type = data['type'],
        content = data['content'];

  Map<String, dynamic> toJson() {
    return {
      'author': author.toJson(),
      'timestamp': timestamp,
      'type': type,
      'content': content
    };
  }

  ///Create a new Chat Text Message by [author] with the message [content]
  ///Automatically sets [timestamp] to now and [type] to Text Message
  Message.createTextMessage({@required this.author, @required this.content})
      : timestamp = DateTime.now().millisecondsSinceEpoch,
        type = 'text';
}

/// Post of the type Event
/// [eventDate] timeAndDate when the post will take place
/// [maxPeople] maximum number of people that can attend the event (-1 if unlimited)
/// [participants] current members of the event. List of User-IDs
/// [location] where the event will start
/// [cost] estimated cost of participation
class Event extends Post {
  int eventDate;
  int maxPeople;
  List<String> participants;
  String location;
  String cost;

  ///Create Event from Firestore Snapshot [data]
  Event.fromJson(var data, String id)
      : eventDate = data['eventDate'],
        maxPeople = data['maxPeople'],
        participants = data['participants'].cast<String>(),
        location = data['location'],
        super.fromJson(data, id);

  ///Create Json Object to Store in Firestore
  Map<String, dynamic> toJson() {
    return {
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
class Buddy extends Post {
  ///Create Buddy from a Firestore Snapshot [data]
  Buddy.fromJson(var data, String id) : super.fromJson(data, id);

  ///Create Json Object to Store in Firestore
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
    };
  }
}

/// Class that holds information about the current Location
///
/// [name] Name of the City
/// [geohash] location of the city
class DeviceLocation {
  DeviceLocation({name, geohash});
  String name;
  String geohash;
}
