part of 'data_models.dart';

// Serialization

Map<String, dynamic> _databaseDocumentToDoc(DatabaseDocument instance,
    {Map<String, dynamic> serialized}) {
  // the ID should not be included in the serialized form
  return serialized;
}

Map<String, dynamic> _userToDoc(User instance,
    {Map<String, dynamic> serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent('name', () => instance.name);

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _groupToDoc(Group instance,
    {Map<String, dynamic> serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('name', () => instance.name);
  serialized.putIfAbsent('about', () => instance.about);
  serialized.putIfAbsent('users', () => instance.users);
  serialized.putIfAbsent('admins', () => instance.admins);
  serialized.putIfAbsent('requestedToJoin', () => instance.requestedToJoin);

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _postToDoc(Post instance,
    {Map<String, dynamic> serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('title', () => instance.title);
  serialized.putIfAbsent('geohash', () => instance.geohash);
  serialized.putIfAbsent('tags', () => createTagMapForJson(instance.tags));
  serialized.putIfAbsent('about', () => instance.about);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('createdDate', () => instance.createdDate);
  serialized.putIfAbsent('expireDate', () => instance.expireDate);
  serialized.putIfAbsent(
      'details', () => instance.details?.map((e) => e?.toMap())?.toList());
  serialized.putIfAbsent('group', () => instance.group?.toMap());
  serialized.putIfAbsent('author', () => instance.author?.toMap());

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _eventToDoc(Event instance,
    {Map<String, dynamic> serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('eventDate', () => instance.eventDate);
  serialized.putIfAbsent('maxPeople', () => instance.maxPeople);
  serialized.putIfAbsent('participants', () => instance.participants);

  return _postToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _buddyToDoc(Buddy instance,
    {Map<String, dynamic> serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  return _postToDoc(instance, serialized: serialized);
}

Map<String, dynamic> _messageToDoc(Message instance,
    {Map<String, dynamic> serialized}) {
  serialized = serialized ?? <String, dynamic>{};

  serialized.putIfAbsent('timestamp', () => instance.timestamp);
  serialized.putIfAbsent('content', () => instance.content);
  serialized.putIfAbsent('type', () => instance.type);
  serialized.putIfAbsent('author', () => instance.author.toMap());

  return _databaseDocumentToDoc(instance, serialized: serialized);
}

// De-Serialization

DatabaseDocument _databaseDocumentFromDoc(
    DatabaseDocument instance, DocumentSnapshot document) {
  instance.id = document.id;
  return instance;
}

User _userFromDoc(User instance, DocumentSnapshot document) {
  instance.name = document.data()['name'] as String;
  return _databaseDocumentFromDoc(instance, document) as User;
}

Message _messageFromDoc(Message instance, DocumentSnapshot document) {
  instance.timestamp = document.data()['timestamp'] as int;
  instance.type = document.data()['type'] as String;
  instance.content = document.data()['content'] as String;
  instance.author = document.data()['author'] == null
      ? null
      : _userFromMap(document.data()['author'] as Map<String, dynamic>);

  return _databaseDocumentFromDoc(instance, document) as Message;
}

Group _groupFromDoc(Group instance, DocumentSnapshot document) {
  instance.name = document.data()['name'] as String;
  instance.about = document.data()['about'] as String;
  instance.users =
      (document.data()['users'] as List)?.map((e) => e as String)?.toList();
  instance.admins =
      (document.data()['admins'] as List)?.map((e) => e as String)?.toList();
  instance.requestedToJoin = (document.data()['requestedToJoin'] as List)
      ?.map((e) => e as String)
      ?.toList();
  instance.requestedToJoin.removeWhere((element) => element == "");
  return _databaseDocumentFromDoc(instance, document) as Group;
}

Post _postFromDoc(Post instance, DocumentSnapshot document) {
  instance.title = document.data()['title'] as String;
  instance.geohash = document.data()['geohash'] as String;
  instance.tags = getTagsFromJson(document.data()['tags']);
  instance.about = document.data()['about'] as String;
  instance.type = document.data()['type'] as String;
  instance.createdDate = document.data()['createdDate'] as int;
  instance.expireDate = document.data()['expireDate'] as int;
  instance.group = document.data()['group'] == null
      ? null
      : GroupInfo.fromMap(document.data()['group'] as Map<String, dynamic>);
  instance.details = (document.data()['details'] as List)
      ?.map((e) =>
          e == null ? null : PostDetail.fromMap(e as Map<String, dynamic>))
      ?.toList();
  instance.author = document.data()['author'] == null
      ? null
      : User.fromMap(document.data()['author'] as Map<String, dynamic>);
  return _databaseDocumentFromDoc(instance, document) as Post;
}

Event _eventFromDoc(Event instance, DocumentSnapshot document) {
  instance.eventDate = document.data()['eventDate'] as int;
  instance.maxPeople = document.data()['maxPeople'] as int;
  instance.participants = (document.data()['participants'] as List)
      ?.map((e) => e as String)
      ?.toList();

  return _postFromDoc(instance, document);
}

Buddy _buddyFromDoc(Buddy instance, DocumentSnapshot document) {
  return _postFromDoc(instance, document);
}

// HELPER FUNCTIONS

///Helper Function to generate Tags List From json
List<String> getTagsFromJson(Map<String, dynamic> json) {
  List<String> tags = [];
  if (json == null) {
    return tags;
  }
  json.forEach((key, value) {
    if (value == true) tags.add(key);
  });
  return tags;
}

///Helper Function to generate TagMap for Database from tag List
///Not tested yet
Map<String, bool> createTagMapForJson(List<String> tags) {
  Map<String, bool> tagMap = Map();
  tags.forEach((tag) {
    tagMap.addEntries([MapEntry(tag, true)]);
  });
  return tagMap;
}
