part of 'create_post_cubit.dart';

@immutable
class CreatePostState {
  //Variables for Validation
  final bool isError;
  final bool isSubmitted;
  final bool isSubmitting;

  final GroupInfo group;
  Map<String, dynamic> mandatoryFields = {
    'title': null,
    'about': null,
    'tags': []
  };
  //optional fields
  Map<String, dynamic> optionalFields = {
    'treffpunkt': null,
    'kosten': null,
  };

  Map<String, dynamic> eventOnlyFields = {
    'maxPeople': -1,
  };

  Map<String, dynamic> buddyOnlyFields = {};

  //Variables to Store
  DateTime eventDate;
  TimeOfDay eventTime;
  CreatePostState(
      {@required this.isError,
      @required this.isSubmitted,
      @required this.isSubmitting,
      this.group,
      this.eventDate,
      this.eventTime,
      Map<String, dynamic> mandatoryFields,
      Map<String, dynamic> buddyOnlyFields,
      Map<String, dynamic> eventOnlyFields,
      Map<String, dynamic> optionalFields}) {
    this.mandatoryFields = mandatoryFields ?? this.mandatoryFields;
    this.buddyOnlyFields = buddyOnlyFields ?? this.buddyOnlyFields;
    this.eventOnlyFields = eventOnlyFields ?? this.eventOnlyFields;
    this.optionalFields = optionalFields ?? this.optionalFields;
  }

  factory CreatePostState.initial({Group group}) {
    GroupInfo groupInfo = null;
    if (group != null) groupInfo = GroupInfo(id: group.id, name: group.name);
    return CreatePostState(
        isError: false,
        isSubmitted: false,
        isSubmitting: false,
        group: groupInfo);
  }

  CreatePostState createSubmitting() {
    return copyWith(isError: false, isSubmitted: false, isSubmitting: true);
  }

  CreatePostState createSuccess() {
    return copyWith(isError: false, isSubmitted: true, isSubmitting: false);
  }

  CreatePostState createError() {
    return copyWith(isError: true, isSubmitted: false, isSubmitting: false);
  }

  CreatePostState copyWith(
      {isError,
      isSubmitting,
      isSubmitted,
      DateTime eventDate,
      TimeOfDay eventTime}) {
    return CreatePostState(
      isError: isError ?? this.isError,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      group: this.group,
      //maps
      mandatoryFields: this.mandatoryFields,
      optionalFields: this.optionalFields,
      eventOnlyFields: this.eventOnlyFields,
      buddyOnlyFields: this.buddyOnlyFields,
    );
  }
}

class LoginInitial extends CreatePostState {}
