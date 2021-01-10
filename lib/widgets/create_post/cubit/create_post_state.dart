part of 'create_post_cubit.dart';

@immutable
class CreatePostState {
  //Variables for Validation
  final bool isError;
  final bool isSubmitted;
  final bool isSubmitting;

  //Group Info is set when post is within group happends with constructor
  final GroupInfo group;
  //All Madatroy Fields
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

  //Must be saved extra otherwise won't work
  //These are also optional
  DateTime eventDate;
  TimeOfDay eventTime;
  //Constructor
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
//Create first initial Staten when post loaded
//Resets validation and sets Group Info if there is a group
//After this only work with Copy with
  factory CreatePostState.initial({Group group}) {
    GroupInfo groupInfo;
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
      group: this
          .group, //Group can not be change later therefore alwasy this.group
      //maps
      mandatoryFields: this.mandatoryFields,
      optionalFields: this.optionalFields,
      eventOnlyFields: this.eventOnlyFields,
      buddyOnlyFields: this.buddyOnlyFields,
    );
  }
}