import 'package:bloc/bloc.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/states/vi_form_state.dart';
import 'package:signup_app/util/tools/debug_tools.dart';
import 'package:signup_app/widgets/post_editor/cubit/post_editor_cubit.dart';
import 'package:signup_app/widgets/post_editor/cubit/post_editor_state.dart';

part 'event_editor_state.dart';

class EventEditorCubit extends Cubit<EventEditorState>
    implements PostEditorCubit {
  Event? event;
  PostRepository _postRepository = new PostRepository();
  EventEditorCubit.newEvent({Group? group})
      : this.event = null,
        super(EventEditorState.newEvent(group: group));
  EventEditorCubit.fromGivenEvent({required Event event})
      : this.event = event,
        super(EventEditorState.fromGivenEvent(event: event));

  void submit() async {
    try {
      emit(state.copyWith(validationState: ViFormState.loading()));
      if (event == null) {
        //Create new Event also set created At
        final UserReference? author = UserRepository().getUserReference();
        if (author == null)
          return emit(state.copyWith(validationState: ViFormState.error()));
        event = new Event(
            author: author,
            title: state.title,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            geohash: await GeoService.getCurrentGeohash(),
            expiresAt: 0, //ToDo expires at
            type: PostType.event,
            tags: state.tags,
            about: state.about,
            maxParticipants: state.maxParticipants,
            eventLocation: state.eventLocation,
            eventAt: state.eventAt,
            costs: state.costs,
            participants: [UserRepository().getUserReference()!],
            group: state.groupReference);
        await _postRepository.createPost(event!);
      } else {
        //update event
        event!.title = state.title;
        event!.tags = state.tags;
        event!.about = state.about;
        event!.maxParticipants = state.maxParticipants;
        event!.eventLocation = state.eventLocation;
        event!.eventAt = state.eventAt;
        event!.costs = state.costs;
        await _postRepository.updatePost(event!);
      }

      emit(state.copyWith(validationState: ViFormState.success()));
    } catch (err) {
      viLog(err, err.toString());
      emit(state.copyWith(validationState: ViFormState.error()));
    }
  }

  //-----------------------------------------
  // Mutuations
  void setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setTags(List<PostTag> tags) {
    emit(state.copyWith(tags: tags));
  }

  void setValidationState(ViFormState validationState) {
    emit(state.copyWith(validationState: validationState));
  }

  void setAbout(String? about) {
    emit(state.copyWith(about: about));
  }

  void setMaxParticipants(int? maxParticipants) {
    emit(state.copyWith(maxParticipants: maxParticipants));
  }

  void setEventAt(int? eventAt) {
    emit(state.copyWith(eventAt: eventAt));
  }

  void setCosts(String? costs) {
    emit(state.copyWith(costs: costs));
  }

  void setEventLocation(String? location) {
    emit(state.copyWith(eventLocation: location));
  }
}
