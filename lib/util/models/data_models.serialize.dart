part of 'data_models.dart';

// SERIALIZATION

Map<String, dynamic> _databaseDocumentToMap(DatabaseDocument instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  if (includeID) {
    serialized.putIfNotNull('id', instance.id);
  }
  return serialized;
}

Map<String, dynamic> _userGeneratedDocumentToMap(UserGeneratedDocument instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull('author', instance.author.toMap(includeID: true));
  return _databaseDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _userReferenceToMap(UserReference instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull("name", instance.name);
  serialized.putIfNotNull("picture", instance.picture);
  return _databaseDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _groupUserReferenceToMap(GroupUserReference instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull("isAdmin", instance.isAdmin);
  return _userReferenceToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _groupReferenceToMap(GroupReference instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull("name", instance.name);
  serialized.putIfNotNull("picture", instance.picture);
  return _databaseDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _userToMap(User instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull('name', instance.name);
  serialized.putIfNotNull('picture', instance.picture);
  serialized.putIfNotNull('savedPosts', instance.savedPosts);
  serialized.putIfNotNull('violationReports', instance.violationReports);
  return _databaseDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _postToMap(Post instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull('title', instance.title);
  serialized.putIfNotNull('createdAt', instance.createdAt);
  serialized.putIfNotNull('expiresAt', instance.expiresAt);
  serialized.putIfNotNull('geohash', instance.geohash);
  serialized.putIfNotNull('type', enumToString(instance.type));
  serialized.putIfNotNull(
      'tags', splitListOfPostTagsToAllSubArrays(instance.tags));
  serialized.putIfNotNull('group', instance.group?.toMap(includeID: true));
  return _userGeneratedDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _eventToMap(Event instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull('about', instance.about);
  serialized.putIfNotNull('costs', instance.costs);
  serialized.putIfNotNull('eventLocation', instance.eventLocation);
  serialized.putIfNotNull('eventAt', instance.eventAt);
  serialized.putIfNotNull('maxParticipants', instance.maxParticipants);
  serialized.putIfNotNull(
      'participants',
      listToJsonList<UserReference>(
          instance.participants, (value) => value.toMap(includeID: true)));
  return _postToMap(instance, serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _buddyToMap(Buddy instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull('buddy', instance.buddy?.toMap(includeID: true));
  return _postToMap(instance, serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _messageToMap(Message instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull('createdAt', instance.createdAt);
  serialized.putIfNotNull('type', enumToString(instance.type));
  serialized.putIfNotNull('content', instance.content);
  return _userGeneratedDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _groupToMap(Group instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull("about", instance.about);
  serialized.putIfNotNull("isPrivate", instance.isPrivate);
  serialized.putIfNotNull(
      "members",
      listToJsonList<GroupUserReference>(
          instance.members, (value) => (value.toMap(includeID: true))));
  serialized.putIfNotNull(
      "requestedToJoin",
      listToJsonList<UserReference>(
          instance.requestedToJoin, (value) => (value.toMap(includeID: true))));
  return _groupReferenceToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _reportToMap(Report instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull("reasons",
      listToJsonList(instance.reasons, (value) => enumToString(value)));
  serialized.putIfNotNull("objectReference", instance.objectReference);
  serialized.putIfNotNull("reportedAt", instance.reportedAt);
  serialized.putIfNotNull("type", enumToString(instance.type));
  serialized.putIfNotNull("state", enumToString(instance.state));

  return _userGeneratedDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

Map<String, dynamic> _bugReportToMap(BugReport instance,
    {Map<String, dynamic>? serialized, bool includeID = false}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfNotNull("title", instance.title);
  serialized.putIfNotNull("message", instance.message);
  serialized.putIfNotNull("type", enumToString(instance.type));
  serialized.putIfNotNull("reportedAt", instance.reportedAt);
  serialized.putIfNotNull("version", instance.version);
  serialized.putIfNotNull("state", enumToString(instance.state));
  serialized.putIfNotNull("comment", instance.comment);

  return _userGeneratedDocumentToMap(instance,
      serialized: serialized, includeID: includeID);
}

// DE-SERIALIZATION

DatabaseDocument _databaseDocumentFromMap(Map<String, dynamic> map,
    {DatabaseDocument? instance}) {
  instance = instance ?? DatabaseDocument.empty();
  instance.id = map['id'] ?? throwSerialExc();
  return instance;
}

UserGeneratedDocument _userGeneratedDocumentFromMap(Map<String, dynamic> map,
    {UserGeneratedDocument? instance}) {
  instance = instance ?? UserGeneratedDocument.empty();
  instance.author = UserReference.fromMap(map['author']);
  return _databaseDocumentFromMap(map, instance: instance)
      as UserGeneratedDocument;
}

UserReference _userReferenceFromMap(Map<String, dynamic> map,
    {UserReference? instance}) {
  instance = instance ?? UserReference.empty();
  instance.name = map['name'] ?? throwSerialExc();
  instance.picture = map['picture'];
  return _databaseDocumentFromMap(map, instance: instance) as UserReference;
}

GroupUserReference _groupUserReferenceFromMap(Map<String, dynamic> map,
    {GroupUserReference? instance}) {
  instance = instance ?? GroupUserReference.empty();
  instance.isAdmin = map['isAdmin'] ?? false;
  return _userReferenceFromMap(map, instance: instance) as GroupUserReference;
}

GroupReference _groupReferenceFromMap(Map<String, dynamic> map,
    {GroupReference? instance}) {
  instance = instance ?? GroupReference.empty();
  instance.name = map['name'] ?? throwSerialExc();
  instance.picture = map['picture'];
  return _databaseDocumentFromMap(map, instance: instance) as GroupReference;
}

User _userFromMap(Map<String, dynamic> map, {User? instance}) {
  instance = instance ?? User.empty();
  instance.name = map['name'] ?? throwSerialExc();
  instance.picture = map['picture'];
  instance.savedPosts = map['savedPosts'];
  instance.violationReports = map['violationReports'];
  return _databaseDocumentFromMap(map, instance: instance) as User;
}

Post _postFromMap(Map<String, dynamic> map, {Post? instance}) {
  instance = instance ?? Post.empty();
  instance.title = map['title'] ?? throwSerialExc();
  instance.createdAt = map['createdAt'] ?? throwSerialExc();
  instance.expiresAt = map['expiresAt'] ?? throwSerialExc();
  instance.geohash = map['geohash'] ?? throwSerialExc();
  instance.tags =
      convertSequenceOfSubArraysToPostTags(map["tags"] ?? throwSerialExc());
  instance.type = stringToEnum(map['type'], PostType.values);
  instance.group =
      map['group'] != null ? GroupReference.fromMap(map['group']) : null;
  return _userGeneratedDocumentFromMap(map, instance: instance) as Post;
}

Event _eventFromMap(Map<String, dynamic> map, {Event? instance}) {
  instance = instance ?? Event.empty();
  instance.about = map['about'];
  instance.eventAt = map['eventAt'];
  instance.maxParticipants = map['maxParticipants'];
  instance.costs = map['costs'];
  instance.eventLocation = map['eventLocation'];
  instance.participants = jsonListToList<UserReference>(
      map['participants'], (value) => UserReference.fromMap(value));
  return _postFromMap(map, instance: instance) as Event;
}

Buddy _buddyFromMap(Map<String, dynamic> map, {Buddy? instance}) {
  instance = instance ?? Buddy.empty();
  Map<String, dynamic>? buddy = map['buddy'];
  instance.buddy = buddy != null ? UserReference.fromMap(buddy) : null;
  return _postFromMap(map, instance: instance) as Buddy;
}

Message _messageFromMap(Map<String, dynamic> map, {Message? instance}) {
  instance = instance ?? Message.empty();
  instance.createdAt = map['createdAt'];
  instance.type = stringToEnum(map['type'], MessageType.values);
  instance.content = map['content'];
  return _userGeneratedDocumentFromMap(map, instance: instance) as Message;
}

Group _groupFromMap(Map<String, dynamic> map, {Group? instance}) {
  instance = instance ?? Group.empty();
  instance.about = map["about"] ?? throwSerialExc();
  instance.isPrivate = map["isPrivate"] ?? false;
  instance.members = jsonListToList<GroupUserReference>(
          map["members"], (value) => GroupUserReference.fromMap(value)) ??
      [];
  instance.requestedToJoin = jsonListToList<UserReference>(
          map["requestedToJoin"], (value) => UserReference.fromMap(value)) ??
      [];
  return _groupReferenceFromMap(map, instance: instance) as Group;
}

Report _reportFromMap(Map<String, dynamic> map, {Report? instance}) {
  instance = instance ?? Report.empty();
  instance.reasons = jsonListToList(map['reasons'],
          (value) => stringToEnum(value, ReportReason.values)) ??
      throwSerialExc();
  instance.objectReference = map["objectReference"] ?? throwSerialExc();
  instance.reportedAt = map["reportedAt"] ?? throwSerialExc();
  instance.type =
      stringToEnum(map["type"], ReportType.values) ?? throwSerialExc();
  instance.state =
      stringToEnum(map["state"], ReportState.values) ?? throwSerialExc();
  return _userGeneratedDocumentFromMap(map, instance: instance) as Report;
}

BugReport _bugReportFromMap(Map<String, dynamic> map, {BugReport? instance}) {
  instance = instance ?? BugReport.empty();

  instance.title = map["title"] ?? throwSerialExc();
  instance.message = map["message"] ?? throwSerialExc();
  instance.type =
      stringToEnum(map["type"], BugReportType.values) ?? throwSerialExc();
  instance.reportedAt = map["reportedAt"] ?? throwSerialExc();
  instance.version = map["version"] ?? throwSerialExc();
  instance.state =
      stringToEnum(map["state"], BugReportState.values) ?? throwSerialExc();
  instance.comment = map["comment"] ?? throwSerialExc();
  return _userGeneratedDocumentFromMap(map, instance: instance) as BugReport;
}

/*Map<String, dynamic> _userToMap(User instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('name', () => instance.name);

  return _databaseDocumentToMap(instance, serialized: serialized);
}

Map<String, dynamic>? _groupToMap(Group instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('name', () => instance.name);
  serialized.putIfAbsent('about', () => instance.about);
  serialized.putIfAbsent('users', () => instance.users);
  serialized.putIfAbsent('admins', () => instance.admins);
  serialized.putIfAbsent('requestedToJoin', () => instance.requestedToJoin);

  return _databaseDocumentToMap(instance, serialized: serialized);
}

Map<String, dynamic>? _postToMap(Post instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('title', () => instance.title);
  serialized.putIfAbsent('geohash', () => instance.geohash);
  serialized.putIfAbsent('tags', () => createTagMapForJson(instance.tags));
  serialized.putIfAbsent('about', () => instance.about);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('createdDate', () => instance.createdDate);
  serialized.putIfAbsent('expireDate', () => instance.expireDate);
  serialized.putIfAbsent(
      'details', () => instance.details.map((e) => e?.toMap()).toList());
  serialized.putIfAbsent('group', () => instance.group?.toMap());
  serialized.putIfAbsent('author', () => instance.author?.toMap());

  return _databaseDocumentToMap(instance, serialized: serialized);
}

Map<String, dynamic>? _bugreportToMap(BugReport instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('title', () => instance.title);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('message', () => instance.message);
  serialized.putIfAbsent('version', () => instance.version);
  serialized.putIfAbsent('timestamp', () => instance.timestamp);
  serialized.putIfAbsent('state', () => instance.state);
  serialized.putIfAbsent('author', () => instance.author?.toMap());

  return _databaseDocumentToMap(instance, serialized: serialized);
}

Map<String, dynamic>? _reportToMap(Report instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('author', () => instance.author?.toMap());
  serialized.putIfAbsent('objectid', () => instance.objectid);
  serialized.putIfAbsent('timestamp', () => instance.timestamp);
  serialized.putIfAbsent('reasons', () => instance.reasons);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('state', () => instance.state);

  return _databaseDocumentToMap(instance, serialized: serialized);
}

Map<String, dynamic>? _eventToMap(Event instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('eventDate', () => instance.eventDate);
  serialized.putIfAbsent('maxPeople', () => instance.maxPeople);
  serialized.putIfAbsent('participants', () => instance.participants);

  return _postToMap(instance, serialized: serialized);
}

Map<String, dynamic>? _buddyToMap(Buddy instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  return _postToMap(instance, serialized: serialized);
}

Map<String, dynamic>? _messageToMap(Message instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('timestamp', () => instance.timestamp);
  serialized.putIfAbsent('content', () => instance.content);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('author', () => instance.author!.toMap());

  return _databaseDocumentToMap(instance, serialized: serialized);
}

// De-Serialization

DatabaseDocument _databaseDocumentFromMap(
    DatabaseDocument instance, DocumentSnapshot document) {
  instance.id = document.id;
  return instance;
}

User _userFromMap(User instance, DocumentSnapshot document) {
  instance.name = document.data()!['name'] as String?;
  return _databaseDocumentFromMap(instance, document) as User;
}

Message _messageFromMap(Message instance, DocumentSnapshot document) {
  instance.timestamp = document.data()!['timestamp'] as int?;
  instance.type = document.data()!['type'] as String?;
  instance.content = document.data()!['content'] as String?;
  instance.author = document.data()!['author'] == null
      ? null
      : _userFromMap(document.data()!['author'] as Map<String, dynamic>);

  return _databaseDocumentFromMap(instance, document) as Message;
}

Group _groupFromMap(Group instance, DocumentSnapshot document) {
  instance.name = document.data()!['name'] as String?;
  instance.about = document.data()!['about'] as String?;
  instance.users =
      (document.data()!['users'] as List?)?.map((e) => e as String).toList();
  instance.admins =
      (document.data()!['admins'] as List?)?.map((e) => e as String).toList();
  instance.requestedToJoin = (document.data()!['requestedToJoin'] as List?)
      ?.map((e) => e as String)
      .toList();
  instance.requestedToJoin!.removeWhere((element) => element == "");
  return _databaseDocumentFromMap(instance, document) as Group;
}

Post _postFromMap(Post instance, DocumentSnapshot document) {
  instance.title = document.data()!['title'] as String;
  instance.geohash = document.data()!['geohash'] as String?;
  instance.tags = getTagsFromJson(document.data()!['tags']);
  instance.about = document.data()!['about'] as String?;
  instance.type = document.data()!['type'] as String;
  instance.createdDate = document.data()!['createdDate'] as int;
  instance.expireDate = document.data()!['expireDate'] as int;
  instance.group = document.data()!['group'] == null
      ? null
      : GroupInfo.fromMap(document.data()!['group'] as Map<String, dynamic>);
  instance.details = (document.data()!['details'] ?? [])
      .map<PostDetail?>((e) =>
          e == null ? null : PostDetail.fromMap(e as Map<String, dynamic>))
      .toList();
  instance.author = document.data()!['author'] == null
      ? null
      : User.fromMap(document.data()!['author'] as Map<String, dynamic>);
  return _databaseDocumentFromMap(instance, document) as Post;
}

Event _eventFromMap(Event instance, DocumentSnapshot document) {
  instance.eventDate = document.data()!['eventDate'] as int?;
  instance.maxPeople = document.data()!['maxPeople'] as int?;
  instance.participants = (document.data()!['participants'] as List?)
      ?.map((e) => e as String)
      .toList();

  return _postFromMap(instance, document) as Event;
}

Buddy _buddyFromMap(Buddy instance, DocumentSnapshot document) {
  return _postFromMap(instance, document) as Buddy;
}
*/
