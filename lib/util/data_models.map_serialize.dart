part of 'data_models.dart';

// Serialization

Map<String, dynamic> _userToMap(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Map<String, dynamic> _postDetailToMap(PostDetail instance) =>
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
    id: map['id'] as String?,
    value: map['value'] as String?,
  );
}

User _userFromMap(Map<String, dynamic> map) {
  return User(
    id: map['id'] as String?,
    name: map['name'] as String?,
  );
}
