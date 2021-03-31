import 'package:bloc/bloc.dart';
import 'package:signup_app/util/presets/globalVariables.dart';

part 'tag_state.dart';

class TagCubit extends Cubit<TagState> {
  TagCubit({List<String>? tags}) : super(TagState(tags));

  void updateTags(String? tag) {
    emit(state.toggleTag(tag));
  }
}
