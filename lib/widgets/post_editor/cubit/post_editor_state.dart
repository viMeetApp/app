import 'package:signup_app/common.dart';
import 'package:signup_app/util/states/vi_form_state.dart';

/// Basis state whith Information for all post Editors. Normally each cubit (e.g. Post Editor Cubit) extends this class
class PostEditorState {
  final String title;
  final List<PostTag> tags;
  final GroupReference? groupReference;

  //Variables for Validation
  final ViFormState validationState;

  //Constructor
  PostEditorState(
      {required this.title,
      required this.tags,
      required this.validationState,
      this.groupReference});

  PostEditorState.newPost({Group? group})
      : this.title = "",
        this.tags = [],
        this.validationState = ViFormState.okay(),
        this.groupReference = group != null
            ? new GroupReference(
                name: group.name, id: group.id, picture: group.picture)
            : null;

  PostEditorState.fromGivenPost({required Post post})
      : this.title = post.title,
        this.tags = post.tags,
        this.groupReference = post.group,
        this.validationState = ViFormState.okay();

  PostEditorState copyWith(
      {String? title, List<PostTag>? tags, ViFormState? validationState}) {
    return PostEditorState(
        title: title ?? this.title,
        tags: tags ?? this.tags,
        validationState: validationState ?? this.validationState,
        groupReference: this.groupReference);
  }
}
