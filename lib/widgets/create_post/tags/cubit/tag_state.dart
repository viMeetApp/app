part of 'tag_cubit.dart';

class TagState {
  Map<String, bool> tagMap = Map<String, bool>.fromIterable(
      GlobalVariables.seaarchTags,
      key: (item) => item,
      value: (item) => false)
    ..remove('event')
    ..remove('buddy');
  TagState();

  TagState toggleTag(String tag) {
    this.tagMap[tag] = !this.tagMap[tag];
    return TagState()..tagMap = this.tagMap;
  }
}
