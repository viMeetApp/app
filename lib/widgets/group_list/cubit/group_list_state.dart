part of 'group_list_cubit.dart';
//!Vermutlich gar nicht notwendig ich lasse jetzt aber mal da

class GroupListState {
  final bool scrollable;
  Stream<List<Group>> groupStream;

  GroupListState({required this.scrollable, required this.groupStream});

  factory GroupListState.initial() =>
      GroupListState(groupStream: Stream.empty(), scrollable: false);

  GroupListState copyWith({Stream<List<Group>>? groupStream, bool? scrollable}) {
    return GroupListState(
        groupStream: groupStream ?? this.groupStream,
        scrollable: scrollable ?? this.scrollable);
  }
}
