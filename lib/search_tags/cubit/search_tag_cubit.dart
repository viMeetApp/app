import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_tag_state.dart';

class SearchTagCubit extends Cubit<SearchTagState> {
  SearchTagCubit() :super(SearchTagState());

  void press(){ state.isExpanded = !state.isExpanded;state.height=state.isExpanded?100:40; emit(state);}
}
