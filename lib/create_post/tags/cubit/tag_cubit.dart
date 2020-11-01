import 'package:bloc/bloc.dart';
import 'package:signup_app/util/globalVariables.dart';

part 'tag_state.dart';

class TagCubit extends Cubit<TagState> {
  TagCubit() : super(TagState());
  void updateTags(String tag) {
    emit(state.toggleTag(tag));
  }
}
