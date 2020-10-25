part of 'search_tag_cubit.dart';

@immutable
class SearchTagState {
  Map<String,bool> tagMap;
  bool isExpanded;
  double height;

  SearchTagState({this.tagMap, this.height, this.isExpanded});

//Das wäre die Stelle um die letzte Konfiguration zu laden
 factory SearchTagState.initial(){
   return SearchTagState(height: 0, isExpanded: false, tagMap: {'kultur': true,'sport': false,'gebaerden': false,'outdoor': false, 'indoor': true,'Frauen':false,'Männer':true, 'Queer': false,'essen':true,'buddy':false});
 }

  SearchTagState toggleTag(String tag){
    this.tagMap[tag]=!this.tagMap[tag];
    return SearchTagState(height: this.height, isExpanded: this.isExpanded, tagMap: this.tagMap);
  }

  SearchTagState toggleFold(){
    if(this.isExpanded==false){
      print("Unfold");
      return SearchTagState(height: null, isExpanded: true, tagMap: this.tagMap);
    }
    else{
      print("Fold");
      return SearchTagState(height: 0, isExpanded: false, tagMap: this.tagMap);
    }
  }
}


