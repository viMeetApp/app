part of 'tag_cubit.dart';

class TagState {
  Map<PostTag, bool> tagMap = Map<PostTag, bool>.fromIterable(
      PostTag.values.toList(),
      key: (item) => item,
      value: (item) => false);

  TagState toggleTag(PostTag tag) {
    this.tagMap[tag] = !(this.tagMap[tag]!);
    return TagState()..tagMap = this.tagMap;
  }

  TagState({List<PostTag> tags = const []}) {
    tags.forEach((tag) {
      tagMap[tag] = true;
    });
  }
}
