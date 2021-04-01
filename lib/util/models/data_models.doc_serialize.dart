part of 'data_models.dart';

// SERIALIZATION

Map<String, dynamic> _databaseDocumentToDoc(DatabaseDocument instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  //serialized.putIfAbsent('name', () => instance.id);
  return serialized;
}

Map<String, dynamic> _userGeneratedDocumentToDoc(UserGeneratedDocument instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('author', () => instance.author.toMap());
  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _userToDoc(User instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('name', () => instance.name);
  serialized.putIfAbsent('picture', () => instance.picture);
  serialized.putIfAbsent('savedPosts', () => instance.savedPosts);
  serialized.putIfAbsent('violationReports', () => instance.violationReports);
  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _postToDoc(Post instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('title', () => instance.title);
  serialized.putIfAbsent('createdAt', () => instance.createdAt);
  serialized.putIfAbsent('expiresAt', () => instance.expiresAt);
  serialized.putIfAbsent('type', () => enumToString(instance.type));
  serialized.putIfAbsent('tags', () => postTagsToMap(instance.tags));
  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _eventToDoc(Event instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('about', () => instance.about);
  serialized.putIfAbsent('costs', () => instance.costs);
  serialized.putIfAbsent('eventLocation', () => instance.eventLocation);
  serialized.putIfAbsent('eventAt', () => instance.eventAt);
  serialized.putIfAbsent('maxParticipants', () => instance.maxParticipants);
  return _postToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _buddyToDoc(Buddy instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('buddy', () => instance.buddy?.toMap());
  return _postToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _groupToDoc(Group instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent("name", () => instance.name);
  serialized.putIfAbsent("picture", () => instance.picture);
  serialized.putIfAbsent("about", () => instance.about);
  serialized.putIfAbsent("isPrivate", () => instance.isPrivate);

  //TODO
  serialized.putIfAbsent("members", () => instance.isPrivate);
  serialized.putIfAbsent("requestedToJoin", () => instance.isPrivate);
  return _databaseDocumentToDoc(instance, serialized: serialized);
}

// DE-SERIALIZATION

DatabaseDocument _databaseDocumentFromDoc(DocumentSnapshot document,
    {DatabaseDocument? instance}) {
  instance = instance ?? DatabaseDocument(id: "");
  instance.id = document.data()?['id'] ?? throwSerialExc();
  return instance;
}

UserGeneratedDocument _userGeneratedDocumentFromDoc(DocumentSnapshot document,
    {UserGeneratedDocument? instance}) {
  instance = instance ?? UserGeneratedDocument(id: "", author: UserReference());
  instance.author = UserReference.fromMap(document.data()?['author']);
  return _databaseDocumentFromDoc(document, instance: instance)
      as UserGeneratedDocument;
}

User _userFromDoc(DocumentSnapshot document, {User? instance}) {
  instance = instance ?? User();
  instance.name = document.data()?['name'] ?? throwSerialExc();
  instance.picture = document.data()?['picture'];
  instance.savedPosts = document.data()?['savedPosts'];
  instance.violationReports = document.data()?['violationReports'];
  return _databaseDocumentFromDoc(document, instance: instance) as User;
}

Post _postFromDoc(Post instance, DocumentSnapshot document) {
  instance.title = document.data()?['title'] ?? throwSerialExc();
  instance.createdAt = document.data()?['createdAt'] ?? throwSerialExc();
  instance.expiresAt = document.data()?['expiresAt'] ?? throwSerialExc();
  instance.geohash = document.data()?['geohash'] ?? throwSerialExc();
  instance.tags = mapToPostTags(document.data()?["tags"] ?? throwSerialExc());
  instance.type = stringToEnum(document.data()?['type'], PostType.values);
  return _userGeneratedDocumentFromDoc(instance, document) as Post;
}

Event _eventFromDoc(Event instance, DocumentSnapshot document) {
  instance.about = document.data()?['about'];
  instance.eventAt = document.data()?['eventAt'];
  instance.maxParticipants = document.data()?['maxParticipants'];
  instance.costs = document.data()?['costs'];
  instance.eventLocation = document.data()?['eventLocation'];
  return _postFromDoc(instance, document) as Event;
}

Buddy _buddyFromDoc(Buddy instance, DocumentSnapshot document) {
  Map<String, dynamic>? buddy = document.data()?['author'];
  instance.buddy = buddy != null ? UserReference.fromMap(buddy) : null;
  return _postFromDoc(instance, document) as Buddy;
}

/*Map<String, dynamic> _userToDoc(User instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('name', () => instance.name);

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic>? _groupToDoc(Group instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('name', () => instance.name);
  serialized.putIfAbsent('about', () => instance.about);
  serialized.putIfAbsent('users', () => instance.users);
  serialized.putIfAbsent('admins', () => instance.admins);
  serialized.putIfAbsent('requestedToJoin', () => instance.requestedToJoin);

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic>? _postToDoc(Post instance,
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

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic>? _bugreportToDoc(BugReport instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('title', () => instance.title);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('message', () => instance.message);
  serialized.putIfAbsent('version', () => instance.version);
  serialized.putIfAbsent('timestamp', () => instance.timestamp);
  serialized.putIfAbsent('state', () => instance.state);
  serialized.putIfAbsent('author', () => instance.author?.toMap());

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic>? _reportToDoc(Report instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('author', () => instance.author?.toMap());
  serialized.putIfAbsent('objectid', () => instance.objectid);
  serialized.putIfAbsent('timestamp', () => instance.timestamp);
  serialized.putIfAbsent('reasons', () => instance.reasons);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('state', () => instance.state);

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic>? _eventToDoc(Event instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('eventDate', () => instance.eventDate);
  serialized.putIfAbsent('maxPeople', () => instance.maxPeople);
  serialized.putIfAbsent('participants', () => instance.participants);

  return _postToDoc(instance, serialized: serialized);
}

Map<String, dynamic>? _buddyToDoc(Buddy instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  return _postToDoc(instance, serialized: serialized);
}

Map<String, dynamic>? _messageToDoc(Message instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('timestamp', () => instance.timestamp);
  serialized.putIfAbsent('content', () => instance.content);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('author', () => instance.author!.toMap());

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

// De-Serialization

DatabaseDocument _databaseDocumentFromDoc(
    DatabaseDocument instance, DocumentSnapshot document) {
  instance.id = document.id;
  return instance;
}

User _userFromDoc(User instance, DocumentSnapshot document) {
  instance.name = document.data()!['name'] as String?;
  return _databaseDocumentFromDoc(instance, document) as User;
}

Message _messageFromDoc(Message instance, DocumentSnapshot document) {
  instance.timestamp = document.data()!['timestamp'] as int?;
  instance.type = document.data()!['type'] as String?;
  instance.content = document.data()!['content'] as String?;
  instance.author = document.data()!['author'] == null
      ? null
      : _userFromMap(document.data()!['author'] as Map<String, dynamic>);

  return _databaseDocumentFromDoc(instance, document) as Message;
}

Group _groupFromDoc(Group instance, DocumentSnapshot document) {
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
  return _databaseDocumentFromDoc(instance, document) as Group;
}

Post _postFromDoc(Post instance, DocumentSnapshot document) {
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
  return _databaseDocumentFromDoc(instance, document) as Post;
}

Event _eventFromDoc(Event instance, DocumentSnapshot document) {
  instance.eventDate = document.data()!['eventDate'] as int?;
  instance.maxPeople = document.data()!['maxPeople'] as int?;
  instance.participants = (document.data()!['participants'] as List?)
      ?.map((e) => e as String)
      .toList();

  return _postFromDoc(instance, document) as Event;
}

Buddy _buddyFromDoc(Buddy instance, DocumentSnapshot document) {
  return _postFromDoc(instance, document) as Buddy;
}
*/
