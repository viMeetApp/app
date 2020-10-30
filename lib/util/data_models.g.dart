// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    uid: json['uid'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
    };

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..about = json['about'] as String
    ..users = (json['users'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'about': instance.about,
      'users': instance.users,
    };

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..geohash = json['geohash'] as String
    ..tags = (json['tags'] as List)?.map((e) => e as String)?.toList()
    ..about = json['about'] as String
    ..type = json['type'] as String
    ..createdDate = json['createdDate'] as int
    ..expireDate = json['expireDate'] as int
    ..group = json['group'] == null
        ? null
        : GroupInfo.fromJson(json['group'] as Map<String, dynamic>)
    ..details = (json['details'] as List)
        ?.map((e) =>
            e == null ? null : PostDetail.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..author = json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'geohash': instance.geohash,
      'tags': instance.tags,
      'about': instance.about,
      'type': instance.type,
      'createdDate': instance.createdDate,
      'expireDate': instance.expireDate,
      'group': instance.group?.toJson(),
      'details': instance.details?.map((e) => e?.toJson())?.toList(),
      'author': instance.author?.toJson(),
    };

PostDetail _$PostDetailFromJson(Map<String, dynamic> json) {
  return PostDetail(
    id: json['id'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$PostDetailToJson(PostDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };

GroupInfo _$GroupInfoFromJson(Map<String, dynamic> json) {
  return GroupInfo(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$GroupInfoToJson(GroupInfo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..timestamp = json['timestamp'] as int
    ..type = json['type'] as String
    ..content = json['content'] as String
    ..author = json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'type': instance.type,
      'content': instance.content,
      'author': instance.author?.toJson(),
    };

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..geohash = json['geohash'] as String
    ..tags = getTagsFromJson(json['tags'])
    ..about = json['about'] as String
    ..type = json['type'] as String
    ..createdDate = json['createdDate'] as int
    ..expireDate = json['expireDate'] as int
    ..group = json['group'] == null
        ? null
        : GroupInfo.fromJson(json['group'] as Map<String, dynamic>)
    ..details = (json['details'] as List)
        ?.map((e) =>
            e == null ? null : PostDetail.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..author = json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>)
    ..eventDate = json['eventDate'] as int
    ..maxPeople = json['maxPeople'] as int
    ..participants =
        (json['participants'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'geohash': instance.geohash,
      'tags': createTagMapForJson(instance.tags),
      'about': instance.about,
      'type': instance.type,
      'createdDate': instance.createdDate,
      'expireDate': instance.expireDate,
      'group': instance.group?.toJson(),
      'details': instance.details?.map((e) => e?.toJson())?.toList(),
      'author': instance.author?.toJson(),
      'eventDate': instance.eventDate,
      'maxPeople': instance.maxPeople,
      'participants': instance.participants,
    };

Buddy _$BuddyFromJson(Map<String, dynamic> json) {
  return Buddy()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..geohash = json['geohash'] as String
    ..tags = getTagsFromJson(json['tags'])
    ..about = json['about'] as String
    ..type = json['type'] as String
    ..createdDate = json['createdDate'] as int
    ..expireDate = json['expireDate'] as int
    ..group = json['group'] == null
        ? null
        : GroupInfo.fromJson(json['group'] as Map<String, dynamic>)
    ..details = (json['details'] as List)
        ?.map((e) =>
            e == null ? null : PostDetail.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..author = json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BuddyToJson(Buddy instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'geohash': instance.geohash,
      'tags': createTagMapForJson(instance.tags),
      'about': instance.about,
      'type': instance.type,
      'createdDate': instance.createdDate,
      'expireDate': instance.expireDate,
      'group': instance.group?.toJson(),
      'details': instance.details?.map((e) => e?.toJson())?.toList(),
      'author': instance.author?.toJson(),
    };
