import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/states/vi_form_state.dart';

abstract class PostEditorCubit {
  void setTitle(String title);

  void setTags(List<PostTag> tags);

  void setValidationState(ViFormState validationState);

  void submit();
}
