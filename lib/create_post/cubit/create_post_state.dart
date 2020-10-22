part of 'create_post_cubit.dart';

@immutable
class CreatePostState {
  final bool isError;
  final bool isSubmitted;
  final bool isSubmitting;

  CreatePostState(
      {@required this.isError,
      @required this.isSubmitted,
      @required this.isSubmitting});
  factory CreatePostState.empty() {
    return CreatePostState(
        isError: false, isSubmitted: false, isSubmitting: false);
  }
  factory CreatePostState.loading() {
    return CreatePostState(
        isError: false, isSubmitted: false, isSubmitting: true);
  }
  factory CreatePostState.success() {
    return CreatePostState(
        isError: false, isSubmitted: true, isSubmitting: false);
  }
  factory CreatePostState.error() {
    return CreatePostState(
        isError: true, isSubmitted: false, isSubmitting: false);
  }
}

class LoginInitial extends CreatePostState {}
