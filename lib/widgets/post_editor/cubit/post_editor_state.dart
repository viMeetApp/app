part of 'post_editor_cubit.dart';

class PostEditorState {
  //ToDo It would be better if we have two subclasses
  final bool isCreate;
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
  PostEditorState(
      {@required this.isError,
      @required this.isSubmitted,
      @required this.isSubmitting,
      @required this.isCreate,
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
  factory PostEditorState.initial({Group group}) {
    GroupInfo groupInfo;
    if (group != null) groupInfo = GroupInfo(id: group.id, name: group.name);
    return PostEditorState(
        isCreate: true,
        isError: false,
        isSubmitted: false,
        isSubmitting: false,
        group: groupInfo);
  }

  factory PostEditorState.fromPost({Post post}) {
    GroupInfo groupInfo = post.group;
    Map<String, dynamic> mandatoryFields = {
      'title': post.title,
      'about': post.about,
      'tags': post.tags
    };
    //optional fields
    Map<String, dynamic> optionalFields = {
      'treffpunkt': post.details.length >= 1 ? post.details[0].value : null,
      'kosten': post.details.length >= 2 ? post.details[1].value : null,
    };
    Map<String, dynamic> eventOnlyFields = {
      'maxPeople': -1,
    };

    Map<String, dynamic> buddyOnlyFields = {};
    DateTime eventDate;
    TimeOfDay eventTime;
    if (post is Event) {
      eventOnlyFields = {
        'maxPeople': post.maxPeople,
      };
      eventDate = post.eventDate != null
          ? DateTime.fromMillisecondsSinceEpoch(post.eventDate)
          : null;
    }

    return PostEditorState(
        isCreate: false,
        isError: false,
        isSubmitted: false,
        isSubmitting: false,
        group: groupInfo)
      ..mandatoryFields = mandatoryFields
      ..optionalFields = optionalFields
      ..eventOnlyFields = eventOnlyFields
      ..buddyOnlyFields = buddyOnlyFields
      ..eventDate = eventDate
      ..eventTime = eventTime;
  }

  PostEditorState createSubmitting() {
    return copyWith(isError: false, isSubmitted: false, isSubmitting: true);
  }

  PostEditorState createSuccess() {
    return copyWith(isError: false, isSubmitted: true, isSubmitting: false);
  }

  PostEditorState createError() {
    return copyWith(isError: true, isSubmitted: false, isSubmitting: false);
  }

  PostEditorState copyWith(
      {isError,
      isSubmitting,
      isSubmitted,
      DateTime eventDate,
      TimeOfDay eventTime}) {
    return PostEditorState(
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
