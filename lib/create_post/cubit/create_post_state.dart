part of 'create_post_cubit.dart';

@immutable
class CreatePostState {
  //Variables for Validation
  final bool isError;
  final bool isSubmitted;
  final bool isSubmitting;

  //Variables to Store
  DateTime eventDate;
  TimeOfDay eventTime;
  CreatePostState(
      {@required this.isError,
      @required this.isSubmitted,
      @required this.isSubmitting,
      this.eventDate,
      this.eventTime});

  factory CreatePostState.empty() {
    return CreatePostState(
        isError: false, isSubmitted: false, isSubmitting: false);
  }
  factory CreatePostState.submitting() {
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

  CreatePostState copyWith({DateTime eventDate, TimeOfDay eventTime}) {
    return CreatePostState(
        isError: this.isError,
        isSubmitted: this.isSubmitted,
        isSubmitting: this.isSubmitting,
        eventDate: eventDate, //Null Values are Ok
        eventTime: eventTime); //Null Values are OK
  }
}

class LoginInitial extends CreatePostState {}
