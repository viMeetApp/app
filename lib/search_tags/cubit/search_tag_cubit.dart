import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_tag_state.dart';

class SearchTagCubit extends Cubit<SearchTagState> {
  SearchTagCubit() :super(SearchTagState());

  void press(){ state.isExpanded = !state.isExpanded;
  state.height=state.isExpanded?null:40; emit(state);}
}
