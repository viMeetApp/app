part of 'search_tag_cubit.dart';

@immutable
class SearchTagState {
  Map<String,bool> tagMap={'kultur': true,'sport': false,'gebaerden': false,'outdoor': false, 'indoor': true,'Frauen':false,'Männer':true, 'Queer': false,'essen':true,'buddy':false};
  bool isExpanded=false;
  double height=20.0;
}


