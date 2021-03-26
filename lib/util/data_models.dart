import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

part 'data_models.doc_serialize.dart';
part 'data_models.map_serialize.dart';

abstract class DocumentSerializable {
  Map<String, dynamic>? toDoc();
  static fromDoc(DocumentSnapshot document) {
    return null;
  }
}

abstract class MapSerializable {
  Map<String, dynamic> toMap();
  static fromMap(Map<String, dynamic> map) {
    return null;
  }
}

/// Database Object that includes an id
///
///  [id] the author of the Object in the database
class DatabaseDocument implements DocumentSerializable {
  String? id;

  @override
  Map<String, dynamic>? toDoc() => _databaseDocumentToDoc(this);

  @override
  static DatabaseDocument fromDoc(DocumentSnapshot document) =>
      _databaseDocumentFromDoc(new DatabaseDocument(), document);
}

/// Object that holds information to a single user as saved in the database
///
/// [id] links a network user to a Firebase-Authentication user
/// [name] name of the user that the user can set himself
class User extends DatabaseDocument implements MapSerializable {
  String? name;
  User({this.name, String? id}) {
    super.id = id;
  }

  @override
  Map<String, dynamic> toDoc() => _userToDoc(this) ?? {};

  @override
  static User fromDoc(DocumentSnapshot document) =>
      _userFromDoc(new User(), document);

  @override
  Map<String, dynamic> toMap() => _userToMap(this);

  @override
  static User fromMap(Map<String, dynamic> map) => _userFromMap(map);
}

/// Class that defines Objects that are created by a user
///
///  [author] the author of the Object
class UserGeneratedContent {
  User? author;
}

/// Object that holds information to a group as saved in the database
///
/// [name] Name of the group
/// [about] Text that informs about the group
/// [users] a list of the userIDs of the users that are in the group
class Group extends DatabaseDocument {
  Group({this.name, this.about, this.admins});
  String? name;
  String? about;
  List<String>? users = [];
  List<String>? admins = [];
  List<String>? requestedToJoin = [];

  @override
  Map<String, dynamic>? toDoc() => _groupToDoc(this);

  @override
  static Group fromDoc(DocumentSnapshot document) =>
      _groupFromDoc(new Group(), document);
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

class Post extends DatabaseDocument implements UserGeneratedContent {
  Post();
  String title = "";
  String? geohash;
  List<String> tags = [];
  String? about;
  String type = "";
  int createdDate = 0;
  int expireDate = 0;
  GroupInfo? group;
  List<PostDetail?> details = [];

  @override
  User? author;

  @override
  Map<String, dynamic>? toDoc() => _postToDoc(this);

  @override
  static Post fromDoc(DocumentSnapshot document) =>
      _postFromDoc(new Post(), document);
}

class PostDetail implements MapSerializable {
  String id;
  String value;

  PostDetail({required this.id, required this.value});

  @override
  Map<String, dynamic> toMap() => _postDetailToMap(this);

  @override
  static PostDetail fromMap(Map<String, dynamic> map) =>
      _postDetailFromMap(map);
}

class GroupInfo implements MapSerializable {
  String? id;
  String? name;

  GroupInfo({required this.id, required this.name});

  @override
  Map<String, dynamic> toMap() => _groupInfoToMap(this);

  @override
  static GroupInfo fromMap(Map<String, dynamic> map) => _groupInfoFromMap(map);
}

/// Object that holds information to a Message from a chat of a post
///
/// [author] user that composed the message
/// [timestamp] the time at which the post was composed
/// [type] indicates if the message is a text or a video message
/// [content] message of the user or reference to the video file
class Message extends DatabaseDocument implements UserGeneratedContent {
  Message();
  int? timestamp;
  String? type;
  String? content;

  @override
  User? author;

  ///Create a new Chat Text Message by [author] with the message [content]
  ///Automatically sets [timestamp] to now and [type] to Text Message
  Message.createTextMessage({required this.author, required this.content})
      : timestamp = DateTime.now().millisecondsSinceEpoch,
        type = 'text';

  @override
  Map<String, dynamic>? toDoc() => _messageToDoc(this);

  @override
  static Message fromDoc(DocumentSnapshot document) =>
      _messageFromDoc(new Message(), document);
}

/// Post of the type Event
/// [eventDate] timeAndDate when the post will take place
/// [maxPeople] maximum number of people that can attend the event (-1 if unlimited)
/// [participants] current members of the event. List of User-IDs
/// [location] where the event will start
/// [cost] estimated cost of participation
class Event extends Post {
  Event();
  int? eventDate;
  int? maxPeople;
  List<String>? participants;

  @override
  Map<String, dynamic>? toDoc() => _eventToDoc(this);

  @override
  static Event fromDoc(DocumentSnapshot document) =>
      _eventFromDoc(new Event(), document);
}

/// Post of the type events
class Buddy extends Post {
  Buddy();

  @override
  Map<String, dynamic>? toDoc() => _buddyToDoc(this);

  @override
  static Buddy fromDoc(DocumentSnapshot document) =>
      _buddyFromDoc(new Buddy(), document);
}

/// Class that holds information about the current Location
///
/// [name] Name of the City
/// [geohash] location of the city
class DeviceLocation {
  DeviceLocation({name, geohash});
  String? name;
  String? geohash;
}

class BugReport extends DatabaseDocument implements UserGeneratedContent {
  String? version;
  int? timestamp;

  String? title;
  String? message;
  String? type;
  @override
  User? author;
  String state = "open";

  @override
  Map<String, dynamic>? toDoc() => _bugreportToDoc(this);
}

class ReportReason {
  const ReportReason(this.id, this.name);
  final String id;
  final String name;
}

// Report for reporting Objects that violate the user agreement
class Report extends DatabaseDocument implements UserGeneratedContent {
  static const REPORT_REASONS = <ReportReason>[
    ReportReason("harassment", "Beleidigung"),
    ReportReason("hate", "Hass"),
    ReportReason("violance", "Androhung von Gewalt"),
    ReportReason("sexualization", "Sexualisierung"),
    ReportReason("copyright", "Copyright Verstoß"),
    ReportReason("misinformation", "Falschinformation"),
    ReportReason("spam", "Spam"),
  ];

  static const TYPE_POST = "post";
  static const TYPE_MESSAGE = "message";
  static const TYPE_USER = "user";

  int? timestamp;
  String? objectid;
  String? type;
  String state = "open";
  List<String>? reasons;

  @override
  User? author;

  @override
  Map<String, dynamic>? toDoc() => _reportToDoc(this);
}
