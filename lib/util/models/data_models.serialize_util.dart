part of 'data_models.dart';

// HELPER FUNCTIONS

throwSerialExc() {
  throw Exception("error during serialization");
}

T stringToEnum<T>(String s, List<T> values) {
  for (T value in values) {
    if (value.toString().toLowerCase().split(".").last == s.toLowerCase()) {
      return value;
    }
  }
  throw Exception(
      "error during serialization: enum entry '" + s + "' not found");
}

String enumToString(dynamic value) {
  return value.toString().toLowerCase().split(".").last;
}

/*String jsonToList(List list){
  
  for()
  return list.map((e) => e as String)
      .toList();
}*/

List<PostTag> mapToPostTags(Map<String, dynamic>? json) {
  List<PostTag> tags = [];
  if (json == null) {
    return tags;
  }
  json.forEach((key, value) {
    if (value == true) tags.add(stringToEnum(key, PostTag.values));
  });
  return tags;
}

Map<String, bool> postTagsToMap(List<PostTag> tags) {
  Map<String, bool> tagMap = Map();
  tags.forEach((tag) {
    tagMap.addEntries(
        [MapEntry(tag.toString().toLowerCase().split(".").last, true)]);
  });
  return tagMap;
}

extension ViMap on Map {
  void putIfNotNull(dynamic key, dynamic? value) {
    if (value != null) {
      this.putIfAbsent(key, () => value);
    }
  }
}

/*List<T> mapToList<T>(Map<String, dynamic>? json,
    T Function(String key, dynamic value) onElement) {
  List<T> tags = [];
  if (json == null) {
    return tags;
  }
  json.forEach((key, value) {
    if (value == true) tags.add(onElement(key, value));
  });
  return tags;
}

Map<String, dynamic> listToMap(List<dynamic> items,
    MapEntry<String, dynamic> Function(dynamic value) onElement) {
  Map<String, bool> tagMap = Map();
  items.forEach((item) {
    tagMap.addEntries([onElement(item)]);
  });
  return tagMap;
}*/
