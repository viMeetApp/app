import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:signup_app/search_tags/view/tag.dart';

part 'data_models.g.dart';

//! IMPORTANT
//! Wenn wir was an der Klasse ändern müssen wir:
//!
//!     flutter pub run build_runner watch
//!
//! aufrufen ODER die signup_app launch configuration ausführen
//! um die serialisierungs-Methoden zu erneuern

/// Object that holds information to a single user as saved in the database
///
/// [uid] links a network user to a Firebase-Authentication user
/// [name] name of the user that the user can set himself

@JsonSerializable(explicitToJson: true)
class User {
  String name;
  String uid;
  User({@required this.name, @required this.uid});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
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

  DatabaseDocument setID(String id) {
    this.id = id;
    return this;
  }
}

/// Object that holds information to a group as saved in the database
///
/// [name] Name of the group
/// [about] Text that informs about the group
/// [users] a list of the userIDs of the users that are in the group
@JsonSerializable(explicitToJson: true)
class Group extends DatabaseDocument {
  Group();
  String name;
  String about;
  List<String> users = [];

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
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

//! Achtung kann Sein, dass man Tags in JSON Serializable immer nach neu mit Funktion tags from Json updaten muss

@JsonSerializable(explicitToJson: true)
class Post extends DatabaseDocument implements UserGeneratedContent {
  Post();
  String title;
  String geohash;
  List<String> tags;
  String about;
  String type;
  int createdDate;
  int expireDate;
  GroupInfo group;
  List<PostDetail> details;

  @override
  User author;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);   
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
///Helper Function to generate Tags List From json
List<String> getTagsFromJson(var json){
  List<String> tags=[];
  json.forEach((key, value) {
      if (value == true) tags.add(key);
    });
    return tags;
}
///Helper Function to generate TagMap for Database from tag List
///Not tested yet
Map<String, bool> createTagMapForJson(List<String> tags){
  Map<String,bool> tagMap=Map();
  tags.forEach((tag) { tagMap.addEntries([MapEntry(tag, true)]);});
  return tagMap;
}
@JsonSerializable(explicitToJson: true)
class PostDetail {
  String id;
  String value;

  PostDetail({@required this.id, @required this.value});

  factory PostDetail.fromJson(Map<String, dynamic> json) =>
      _$PostDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PostDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GroupInfo {
  String id;
  String name;

  GroupInfo({@required this.id, @required this.name});

  factory GroupInfo.fromJson(Map<String, dynamic> json) =>
      _$GroupInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GroupInfoToJson(this);
}

/// Object that holds information to a Message from a chat of a post
///
/// [author] user that composed the message
/// [timestamp] the time at which the post was composed
/// [type] indicates if the message is a text or a video message
/// [content] message of the user or reference to the video file
@JsonSerializable(explicitToJson: true, nullable: true)
class Message implements UserGeneratedContent {
  Message();
  int timestamp;
  String type;
  String content;

  @override
  User author;

  ///Create a new Chat Text Message by [author] with the message [content]
  ///Automatically sets [timestamp] to now and [type] to Text Message
  Message.createTextMessage({@required this.author, @required this.content})
      : timestamp = DateTime.now().millisecondsSinceEpoch,
        type = 'text';

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

/// Post of the type Event
/// [eventDate] timeAndDate when the post will take place
/// [maxPeople] maximum number of people that can attend the event (-1 if unlimited)
/// [participants] current members of the event. List of User-IDs
/// [location] where the event will start
/// [cost] estimated cost of participation
@JsonSerializable(explicitToJson: true, nullable: true)
class Event extends Post {
  Event();
  int eventDate;
  int maxPeople;
  List<String> participants;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

/// Post of the type events
/// TODO: talk about needed fields

@JsonSerializable(explicitToJson: true)
class Buddy extends Post {
  Buddy();

  factory Buddy.fromJson(Map<String, dynamic> json) => _$BuddyFromJson(json);
  Map<String, dynamic> toJson() => _$BuddyToJson(this);
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
