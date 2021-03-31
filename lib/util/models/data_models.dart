import 'package:cloud_firestore/cloud_firestore.dart';

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
/// [id] the id of the document within the databse
class DatabaseDocument implements DocumentSerializable {
  String id = "";

  @override
  Map<String, dynamic>? toDoc() => _databaseDocumentToDoc(this);

  @override
  static DatabaseDocument fromDoc(DocumentSnapshot document) =>
      _databaseDocumentFromDoc(new DatabaseDocument(), document);
}

/// Document that also contains
///
/// [author] the author of the Object
class UserGeneratedDocument extends DatabaseDocument {
  UserReference author = UserReference();
}

/// Lightweigt user that can be used within other documents
///
/// [name] the custom name of the user.
/// [picture] the id of the picture in the storage bucket.
class UserReference extends DatabaseDocument {
  String name = "";
  String? picture;
}

/// extension of UserReference to include group specific data
///
/// [isAdmin] whether the user is an admin of the given group.
class GroupUserReference extends UserReference {
  bool isAdmin = false;
}

/// Lightweigt group that can be used within other documents
///
/// [name] the given name of the group.
/// [picture] the id of the picture in the storage bucket.
class GroupReference extends DatabaseDocument {
  String name = "";
  String? picture;
}

/// User model to be saved to the database
///
/// [savedPosts] contains the ids of the posts that have been saved by the user
/// [violationReports] contains the ids of reports filed against the user
class User extends UserReference {
  List<String> savedPosts = [];
  List<String> violationReports = [];
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
  String title = "";
  int createdAt = -1;
  int expiresAt = -1;
  String geohash = "";

  PostType type = PostType.event;
  List<PostTag> tags = [];
}

/// model for an event with multiple participants
class Event extends Post {
  String? about;
  int? maxParticipants;
  String? eventAt;
  String? costs;
  String? eventLocation;
}

/// model for a post with just one participant
class Buddy {
  UserReference? buddy;
}

/// model for groups in which posts can be published
///
/// [about] contains a description of the group.
/// [isPrivate] determines whether an approval process is neccessary to join.
/// [members] are the members and admins of the group
/// [requestedToJoin] are the members in the approval process
class Group extends GroupReference {
  String about = "";
  bool isPrivate = false;
  List<GroupUserReference> members = [];
  List<UserReference>? requestedToJoin;
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
  List<ReportReason> reasons = [];
  DocumentReference? objectReference;
  int reportedAt = -1;
  ReportType type = ReportType.post;
  ReportState state = ReportState.open;
}

enum BugReportType { ui, logic, functionality, request, other }
enum BugReportState { open, closed }

class BugReport extends UserGeneratedDocument {
  String title = "";
  String message = "";
  BugReportType type = BugReportType.other;
  int reportedAt = -1;
  String version = "";

  // nur durch Admins setzbar
  BugReportState? state;
  String? comment;
}
