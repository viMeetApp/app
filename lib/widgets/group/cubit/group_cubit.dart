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
  GroupCubit({required Group group}) : super(GroupUninitialized()) {
    _checkAndEmitGroupState(group);
    //Im ersten Schritt wird Bloc mit einer geladenen Gruppe versorgt,
    //um aber dynamisches zu behalten wird gleichzeitig verbindung zu Firestore aufgebaut
    //um ab da dynamische Gruppe zu haben.

    GroupInteractions.getGroupInfo(group.id, (group) {
      _checkAndEmitGroupState(group);
    });
  }

  void withdrawJoinRequest() {
    /*emit((state as NotGroupMember).copyWith(requesting: true));*/
    //TODO: Implement a way to withdraw a join request
  }

  void requestToJoinGroup() {
    emit((state as NotGroupMember).copyWith(requesting: true));
    GroupInteractions.joinGroup(state.group!.id, (success) {
      print(success
          ? "Subscribed Sucessfully"
          : "There was an error subscribing");
    });
  }

  void _checkAndEmitGroupState(Group group) {
    GroupUserReference? selfReference =
        group.members.firstWhereOrNull((member) => member.id == userId);
    if (selfReference != null) {
      if (selfReference.isAdmin) {
        return emit(GroupAdmin(group: group));
      }
      return emit(GroupMember(group: group));
    }
    return emit(NotGroupMember(group: group));
  }
}
