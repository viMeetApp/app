part of 'search_tag_cubit.dart';

@immutable
class SearchTagState {
  final Map<String?, bool>? tagMap;
  final bool? isExpanded;

  SearchTagState({this.tagMap, this.isExpanded});

//Das wäre die Stelle um die letzte Konfiguration zu laden
  factory SearchTagState.initial() {
    return SearchTagState(
        isExpanded: false,
        tagMap: Map<String?, bool>.fromIterable(GlobalVariables.seaarchTags,
            key: (item) => item, value: (item) => false));
  }

  SearchTagState toggleTag(String? tag) {
    this.tagMap![tag] = !this.tagMap![tag]!;
    return SearchTagState(isExpanded: this.isExpanded, tagMap: this.tagMap);
  }

  SearchTagState toggleFold() {
    if (this.isExpanded == false) {
      return SearchTagState(isExpanded: true, tagMap: this.tagMap);
    } else {
      return SearchTagState(isExpanded: false, tagMap: this.tagMap);
    }
  }
}
