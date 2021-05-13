part of 'event_editor_cubit.dart';

class EventEditorState extends PostEditorState {
  final String? about;
  final int maxParticipants;
  final int? eventAt;
  final String? costs;
  final String? eventLocation;

  EventEditorState(
      {this.about,
      required this.maxParticipants,
      this.eventAt,
      this.costs,
      this.eventLocation,
      required String title,
      required List<PostTag> tags,
      required ViFormState validationState,
      GroupReference? groupReference})
      : super(
            title: title,
            tags: tags,
            validationState: validationState,
            groupReference: groupReference);

  EventEditorState.newEvent({Group? group})
      : this.maxParticipants = -1,
        this.about = null,
        this.eventAt = null,
        this.costs = null,
        this.eventLocation = null,
        super.newPost(group: group);

  EventEditorState.fromGivenEvent({required Event event})
      : this.maxParticipants = event.maxParticipants ?? -1,
        this.about = event.about,
        this.eventAt = event.eventAt,
        this.costs = event.costs,
        this.eventLocation = event.eventLocation,
        super.fromGivenPost(post: event);

  EventEditorState copyWith({
    String? title,
    List<PostTag>? tags,
    ViFormState? validationState,
    String? about,
    int? maxParticipants,
    int? eventAt,
    String? costs,
    String? eventLocation,
  }) {
    return EventEditorState(
        title: title ?? this.title,
        tags: tags ?? this.tags,
        validationState: validationState ?? this.validationState,
        about: about ?? this.about,
        maxParticipants: maxParticipants ?? this.maxParticipants,
        eventAt: eventAt ?? this.eventAt,
        costs: costs ?? this.costs,
        eventLocation: eventLocation ?? this.eventLocation,
        groupReference: this.groupReference);
  }
}
