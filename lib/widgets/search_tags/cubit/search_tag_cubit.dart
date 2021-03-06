import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/common.dart';

part 'search_tag_state.dart';

class SearchTagCubit extends Cubit<SearchTagState> {
  SearchTagCubit() : super(SearchTagState.initial());

  ///Filter widget fold and unfold
  void toggleFold() {
    emit(state.toggleFold());
  }

  ///Is called from Tag when tag is pressed -> updates the Tag Array
  void updateFilterTags(PostTag tag) {
    emit(state.toggleTag(tag));
  }
}
