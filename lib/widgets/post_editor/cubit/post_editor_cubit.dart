import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/states/vi_form_state.dart';

/// Abstract class which defines an interface for all Post Editor Cubits
abstract class PostEditorCubit {
  void setTitle(String title);

  void setTags(List<PostTag> tags);

  void setValidationState(ViFormState validationState);

  void submit();
}
