import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'data_models.doc_serialize.dart';
part 'data_models.map_serialize.dart';
part 'data_models.serialize_util.dart';

abstract class DocumentSerializable {
  Map<String, dynamic>? toDoc();
  //abstract factory DocumentSerializable.fromDoc(DocumentSnapshot document);
}

abstract class MapSerializable {
  Map<String, dynamic> toMap();
  /*static fromMap(Map<String, dynamic> map) {
    return null;
  }*/
}

/// Database Object that includes an id
///
/// [id] the id of the document within the databse
class DatabaseDocument implements DocumentSerializable {
  String id;

  DatabaseDocument({required this.id});

  DatabaseDocument.empty() : this.id = "";

  @override
  Map<String, dynamic>? toDoc() => _databaseDocumentToDoc(this);

  factory DatabaseDocument.fromDoc(DocumentSnapshot document) =>
      _databaseDocumentFromDoc(document);
}

/// Document that also contains
///
/// [author] the author of the Object
class UserGeneratedDocument extends DatabaseDocument {
  UserReference author;

  UserGeneratedDocument({required String id, required this.author})
      : super(id: id);

  UserGeneratedDocument.empty()
      : author = UserReference.empty(),
        super.empty();

  @override
  Map<String, dynamic>? toDoc() => _userGeneratedDocumentToDoc(this);

  @override
  factory UserGeneratedDocument.fromDoc(DocumentSnapshot document) =>
      _userGeneratedDocumentFromDoc(document);
}

/// Lightweigt user that can be used within other documents
///
/// [name] the custom name of the user.
/// [picture] the id of the picture in the storage bucket.
class UserReference extends DatabaseDocument implements MapSerializable {
  String name;
  String? picture;

  UserReference({required String id, required this.name, this.picture})
      : super(id: id);

  UserReference.empty()
      : this.name = "",
        super.empty();

  @override
  Map<String, dynamic> toMap() => _userReferenceToMap(this);

  @override
  factory UserReference.fromMap(Map<String, dynamic> map) =>
      _userReferenceFromMap(map);
}

/// extension of UserReference to include group specific data
///
/// [isAdmin] whether the user is an admin of the given group.
class GroupUserReference extends UserReference {
  bool isAdmin;

  GroupUserReference({
    required String id,
    required String name,
    String? picture,
    this.isAdmin = false,
  }) : super(id: id, name: name, picture: picture);

  GroupUserReference.empty()
      : isAdmin = false,
        super.empty();

  @override
  Map<String, dynamic> toMap() => _groupUserReferenceToMap(this);

  @override
  factory GroupUserReference.fromMap(Map<String, dynamic> map) =>
      _groupUserReferenceFromMap(map);
}

/// Lightweigt group that can be used within other documents
///
/// [name] the given name of the group.
/// [picture] the id of the picture in the storage bucket.
class GroupReference extends DatabaseDocument implements MapSerializable {
  String name;
  String? picture;

  GroupReference({required String id, required this.name, this.picture})
      : super(id: id);

  GroupReference.empty()
      : this.name = "",
        super.empty();

  @override
  Map<String, dynamic> toMap() => _groupReferenceToMap(this);

  @override
  factory GroupReference.fromMap(Map<String, dynamic> map) =>
      _groupReferenceFromMap(map);
}

/// User model to be saved to the database
///
/// [savedPosts] contains the ids of the posts that have been saved by the user
/// [violationReports] contains the ids of reports filed against the user
class User extends UserReference {
  List<String>? savedPosts;
  List<String>? violationReports;

  User({
    required String id,
    required String name,
    String? picture,
    this.savedPosts,
  }) : super(id: id, name: name, picture: picture);

  User.empty() : super.empty();

  @override
  Map<String, dynamic>? toDoc() => _userToDoc(this);

  @override
  factory User.fromDoc(DocumentSnapshot document) => _userFromDoc(document);
}

enum PostType { event, buddy }

enum PostTag {
  culture,
  sport,
  sign,
  outdoor,
  indoor,
  men,
  women,
  queer,
  food,
  online
}

/// model for a post published by the user. This can be an event or a buddy
///
/// [title] is the section of the post shown on overview screens.
/// [createdAt] is a unix timestamp of when the post was uploaded.
/// [expiresAt] is a unix timestamp of when the post gets deleted by the server.
/// [geohash] is a geohash of where the post was published
/// [type] gives information about the nature of the post
/// [tags] is a list of tags that the post might have
class Post extends UserGeneratedDocument {
  String title;
  int createdAt;
  int expiresAt;
  String geohash;
  PostType type;
  List<PostTag> tags;

  Post({
    required String id,
    required UserReference author,
    required this.title,
    required this.createdAt,
    required this.expiresAt,
    required this.geohash,
    required this.type,
    required this.tags,
  }) : super(id: id, author: author);

  Post.empty()
      : title = "",
        createdAt = -1,
        expiresAt = -1,
        geohash = "",
        type = PostType.event,
        tags = [],
        super.empty();

  @override
  Map<String, dynamic>? toDoc() => _postToDoc(this);

  @override
  factory Post.fromDoc(DocumentSnapshot document) => _postFromDoc(document);
}

/// model for an event with multiple participants
class Event extends Post {
  String? about;
  int? maxParticipants;
  int? eventAt;
  String? costs;
  String? eventLocation;

  Event(
      {required String id,
      required UserReference author,
      required String title,
      required int createdAt,
      required int expiresAt,
      required String geohash,
      required PostType type,
      required List<PostTag> tags,
      this.about,
      this.maxParticipants,
      this.eventAt,
      this.costs,
      this.eventLocation})
      : super(
            id: id,
            author: author,
            title: title,
            createdAt: createdAt,
            expiresAt: expiresAt,
            geohash: geohash,
            type: type,
            tags: tags);

  Event.empty() : super.empty();

  @override
  Map<String, dynamic>? toDoc() => _eventToDoc(this);

  @override
  factory Event.fromDoc(DocumentSnapshot document) => _eventFromDoc(document);
}

/// model for a post with just one participant
class Buddy extends Post {
  UserReference? buddy;

  Buddy(
      {required String id,
      required UserReference author,
      required String title,
      required int createdAt,
      required int expiresAt,
      required String geohash,
      required PostType type,
      required List<PostTag> tags,
      this.buddy})
      : super(
            id: id,
            author: author,
            title: title,
            createdAt: createdAt,
            expiresAt: expiresAt,
            geohash: geohash,
            type: type,
            tags: tags);

  Buddy.empty() : super.empty();

  @override
  Map<String, dynamic>? toDoc() => _buddyToDoc(this);

  @override
  factory Buddy.fromDoc(DocumentSnapshot document) => _buddyFromDoc(document);
}

/// model for groups in which posts can be published
///
/// [about] contains a description of the group.
/// [isPrivate] determines whether an approval process is neccessary to join.
/// [members] are the members and admins of the group
/// [requestedToJoin] are the members in the approval process
class Group extends GroupReference {
  String about;
  bool isPrivate;
  List<GroupUserReference> members;
  List<UserReference>? requestedToJoin;

  Group(
      {required String id,
      required String name,
      String? picture,
      required this.about,
      required this.isPrivate,
      required this.members,
      this.requestedToJoin})
      : super(id: id, name: name, picture: picture);

  Group.empty()
      : this.about = "",
        this.isPrivate = false,
        this.members = [],
        super.empty();

  /*@override
  Map<String, dynamic>? toDoc() => _groupToDoc(this);

  @override
  factory Group.fromDoc(DocumentSnapshot document) =>
      _groupFromDoc(new Group(), document);*/
}

enum ReportReason {
  harassment,
  hate,
  violance,
  sexualization,
  copyright,
  misinformation,
  spam
}
enum ReportState { open, accepted, rejected }
enum ReportType { post, message, user }

class Report extends UserGeneratedDocument {
  List<ReportReason> reasons;
  int reportedAt;
  ReportType type;
  ReportState state;
  DocumentReference? objectReference;

  Report({
    required String id,
    required UserReference author,
    required this.reasons,
    required this.reportedAt,
    required this.type,
    required this.state,
    required this.objectReference,
  }) : super(id: id, author: author);

  Report.empty()
      : this.reasons = [],
        this.reportedAt = -1,
        this.type = ReportType.post,
        this.state = ReportState.open,
        super.empty();
}

enum BugReportType { ui, logic, functionality, request, other }
enum BugReportState { open, closed }

class BugReport extends UserGeneratedDocument {
  String title;
  String message;
  BugReportType type;
  int reportedAt;
  String version;

  // nur durch Admins setzbar
  BugReportState? state;
  String? comment;

  BugReport({
    required String id,
    required UserReference author,
    required this.title,
    required this.message,
    required this.type,
    required this.reportedAt,
    required this.version,
    this.state,
    this.comment,
  }) : super(id: id, author: author);

  BugReport.empty()
      : this.title = "",
        this.message = "",
        this.type = BugReportType.other,
        this.reportedAt = -1,
        this.version = "",
        super.empty();
}
