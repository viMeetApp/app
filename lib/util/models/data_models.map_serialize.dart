part of 'data_models.dart';

// Serialization

Map<String, dynamic> _userReferenceToMap(UserReference instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent("id", () => instance.id);
  serialized.putIfAbsent("name", () => instance.name);
  serialized.putIfAbsent("picture", () => instance.picture);
  return serialized;
}

Map<String, dynamic> _groupUserReferenceToMap(GroupUserReference instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent("isAdmin", () => instance.isAdmin);
  return _userReferenceToMap(instance, serialized: serialized);
}

// De-Serialization

UserReference _userReferenceFromMap(
    UserReference instance, Map<String, dynamic> map) {
  instance.id = map['id'] ?? throwSerialExc();
  instance.name = map['name'] ?? throwSerialExc();
  instance.picture = map['picture'];
  return instance;
}

GroupUserReference _groupUserReferenceFromMap(
    GroupUserReference instance, Map<String, dynamic> map) {
  instance.isAdmin = map['isAdmin'] ?? false;
  return _userReferenceFromMap(instance, map) as GroupUserReference;
}

/*Map<String, dynamic> _postDetailToMap(PostDetail instance) =>
    <String, dynamic>{'id': instance.id, 'value': instance.value};

Map<String, dynamic> _groupInfoToMap(GroupInfo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// De-Serialization

GroupInfo _groupInfoFromMap(Map<String, dynamic> map) {
  return GroupInfo(
    id: map['id'] as String?,
    name: map['name'] as String?,
  );
}

PostDetail _postDetailFromMap(Map<String, dynamic> map) {
  return PostDetail(
    id: map['id'] as String,
    value: map['value'] as String,
  );
}

User _userFromMap(Map<String, dynamic> map) {
  return User(
    id: map['id'] as String?,
    name: map['name'] as String?,
  );
}*/
