import 'package:bloc/bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/presets/globalVariables.dart';

part 'tag_state.dart';

class TagCubit extends Cubit<TagState> {
  TagCubit({List<PostTag> tags = const []}) : super(TagState(tags: tags));

  void updateTags(PostTag tag) {
    emit(state.toggleTag(tag));
  }
}
