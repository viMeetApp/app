import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/repositories/group_interactions.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:collection/collection.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  GroupCubit({required Group group})
      : super(_getCurrentGroupState(
            group, FirebaseAuth.instance.currentUser!.uid)) {
    //Subscribe to Group to keep information up to date
    GroupInteractions.getGroupInfo(group.id, (group) {
      emit(_getCurrentGroupState(group, userId));
    });
  }

  void withdrawJoinRequest() {
    /*emit((state as NotGroupMember).copyWith(requesting: true));*/
    //TODO: Implement a way to withdraw a join request
  }

  void requestToJoinGroup() {
    emit((state as NotGroupMember).copyWith(requesting: true));
    GroupInteractions.joinGroup(
      state.group.id,
      (success) {
        if (!success) {
          emit((state as NotGroupMember).copyWith(requesting: false));
        }
      },
    );
  }

  static GroupState _getCurrentGroupState(Group group, String userId) {
    final GroupUserReference? ownRef =
        group.members.firstWhereOrNull((member) => member.id == userId);
    if (ownRef != null) {
      return (ownRef.isAdmin
          ? GroupAdmin(group: group)
          : GroupMember(group: group));
    }
    return (NotGroupMember(group: group));
  }
}
