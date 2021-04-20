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

/// Splits List of PostTags into all possible subArrays to allow querying for tags in the Backend
///
/// All possible options means all options but always in the same ordering. Therer are a total of 2^n -1 valid options
List<String> splitListOfPostTagsToAllSubArrays(List<PostTag> tags) {
  List<String> subArrays = [];
  //Pick starting point
  for (int i = 0; i < tags.length; ++i) {
    //Pick endig point
    for (int j = i; j < tags.length; ++j) {
      String elementString = "";
      for (int k = i; k <= j; ++k) {
        elementString += enumToString(tags[k]) + ',';
      }
      subArrays.add(elementString.substring(0, elementString.length - 1));
    }
  }
  return subArrays;
}

/// Converts List of Sub String (from Tags) as used in the Backend to associated List of PostTags
List<PostTag> convertSequenceOfSubArraysToPostTags(List<dynamic> subStrings) {
  if (subStrings.length == 0)
    return [];
  else if (subStrings.length == 1)
    return [stringToEnum(subStrings[0], PostTag.values)];
  //Find Longest Substring
  String longestSubstring = "";
  subStrings.forEach((subString) {
    if (subString.length > longestSubstring.length)
      longestSubstring = subString;
  });

  List<String> list = longestSubstring.split(',');
  return list
      .map((String subString) => stringToEnum(subString, PostTag.values))
      .toList();
}

Map<String, bool> postTagsToMap(List<PostTag> tags) {
  List<PostTag> allTags = PostTag.values.toList();
  Map<String, bool> tagMap = Map();

  allTags.forEach((tag) {
    if (tags.contains(tag)) {
      tagMap.addEntries([MapEntry(enumToString(tag), true)]);
    } else {
      tagMap.addEntries([MapEntry(enumToString(tag), false)]);
    }
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
  Map<String, dynamic> result = snapshot.data() ?? {};
  result.putIfNotNull("id", snapshot.id);
  return result;
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
