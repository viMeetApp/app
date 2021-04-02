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

Map<String, dynamic> _groupReferenceToMap(GroupReference instance,
    {Map<String, dynamic>? serialized}) {
  serialized = serialized ?? <String, dynamic>{};
  serialized.putIfAbsent("id", () => instance.id);
  serialized.putIfAbsent("name", () => instance.name);
  serialized.putIfAbsent("picture", () => instance.picture);
  return serialized;
}

// De-Serialization

UserReference _userReferenceFromMap(Map<String, dynamic> map,
    {UserReference? instance}) {
  instance = instance ?? UserReference.empty();
  instance.id = map['id'] ?? throwSerialExc();
  instance.name = map['name'] ?? throwSerialExc();
  instance.picture = map['picture'];
  return instance;
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
  instance.id = map['id'] ?? throwSerialExc();
  instance.name = map['name'] ?? throwSerialExc();
  instance.picture = map['picture'];
  return instance;
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
