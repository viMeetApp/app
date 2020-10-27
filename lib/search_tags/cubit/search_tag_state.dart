part of 'search_tag_cubit.dart';

@immutable
class SearchTagState {
  Map<String, bool> tagMap;
  bool isExpanded;

  SearchTagState({this.tagMap, this.isExpanded});

//Das wäre die Stelle um die letzte Konfiguration zu laden
  factory SearchTagState.initial() {
    return SearchTagState(isExpanded: false, tagMap: {
      'kultur': false,
      'sport': false,
      'gebaerden': false,
      'outdoor': false,
      'indoor': false,
      'Frauen': false,
      'Männer': false,
      'Queer': false,
      'essen': false,
      'buddy': false
    });
  }

  SearchTagState toggleTag(String tag) {
    this.tagMap[tag] = !this.tagMap[tag];
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
