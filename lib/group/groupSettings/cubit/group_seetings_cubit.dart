import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:meta/meta.dart';
import 'package:signup_app/util/data_models.dart';

part 'group_seetings_state.dart';

class GroupSeetingsCubit extends Cubit<GroupSettingsState> {
  final userId = fire.FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GroupSeetingsCubit({@required Group group})
      : super(GroupSettingsUninitialized()) {
    _checkAndEmitMatchingState(group: group);
  }

  Future<void> updateGroupSettings({String about}) async {
    if (about != null) state.group.about = about;
    try {
      await _firestore
          .collection('groups')
          .doc(state.group.id)
          .update(state.group.toJson());
    } catch (err) {
      return Future.error("Error update Group Settings");
    }
  }

  void accepRequest({@required User user}) {
    state.group.requestedToJoin.remove(user.uid);
    state.group.users.add(user.uid);
    var ref = _firestore.collection('groups').doc(state.group.id);
    ref.update(state.group.toJson()).then((value) {
      log("Accepted Sucessfully");
      _checkAndEmitMatchingState(group: state.group);
    }).catchError((err) => log("Error"));
  }

  void declineRequest({@required User user}) {
    state.group.requestedToJoin.remove(user.uid);
    var ref = _firestore.collection('groups').doc(state.group.id);
    ref.update(state.group.toJson()).then((value) {
      log("Declined Sucessfully");
      _checkAndEmitMatchingState(group: state.group);
    }).catchError((err) => log("Error"));
  }

  void _checkAndEmitMatchingState({Group group}) {
    //Create User and State Map
    if (group.admins.contains(userId)) {
      emit(AdminSettings()..group = group);
    } else if (group.users.contains(userId)) {
      emit(MemberSettings()..group = group);
    }
  }
}
