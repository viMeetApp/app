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

List<PostTag> listToPostTags(List<dynamic>? tags) {
  if (tags == null) {
    return [];
  } else {
    return tags.map((tag) => stringToEnum(tag, PostTag.values)).toList();
  }
}

List<String> postTagsToList(List<PostTag>? tags) {
  if (tags == null) {
    return [];
  } else {
    return tags.map((tag) => enumToString(tag)).toList();
  }
}

extension ViMap on Map {
  void putIfNotNull(dynamic key, dynamic value) {
    if (value != null) {
      this.putIfAbsent(key, () => value);
    }
  }
}

List<T>? jsonListToList<T>(
    List<dynamic>? json, T Function(dynamic value) onElement) {
  if (json == null) {
    return null;
  }
  List<T> result = [];
  json.forEach((value) {
    result.add(onElement(value));
  });
  return result;
}

List<dynamic>? listToJsonList<T>(
    List<T>? list, dynamic Function(T value) onElement) {
  if (list == null) {
    return null;
  }
  List<dynamic> result = [];
  list.forEach((value) {
    result.add(onElement(value));
  });

  return result;
}

Map<String, dynamic> docToMap(DocumentSnapshot snapshot) {
  Map<String, dynamic> result =
      (snapshot as DocumentSnapshot<Map<String, dynamic>>).data() ?? {};
  result.putIfNotNull("id", snapshot.id);
  return result;
}
