import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:meta/meta.dart';
import 'package:signup_app/group/cubit/group_cubit.dart';
import 'package:signup_app/util/data_models.dart';

part 'group_seetings_state.dart';

class GroupSeetingsCubit extends Cubit<GroupSettingsState> {
  final userId = fire.FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GroupSeetingsCubit({@required Group group})
      : super(GroupSettingsUninitialized()) {
    _checkAndEmitAdminState(group: group);
  }

  Future<void> updateGroupSettings({String about}) async {
    if (about != null) state.group.about = about;
    try {
      await _firestore
          .collection('groups')
          .doc(state.group.id)
          .update(state.group.toJson());
      //_checkAndEmitAdminState(group: state.group); //!Das kann man eigenlich weglassem da alle änderungen ja schon sichtbar
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
      _checkAndEmitAdminState(group: state.group);
    }).catchError((err) => log("Error"));
  }

  void declineRequest({@required User user}) {
    state.group.requestedToJoin.remove(user.uid);
    var ref = _firestore.collection('groups').doc(state.group.id);
    ref.update(state.group.toJson()).then((value) {
      log("Declined Sucessfully");
      _checkAndEmitAdminState(group: state.group);
    }).catchError((err) => log("Error"));
  }

  void _checkAndEmitAdminState({Group group}) {
    //Create User and State Map
    Map<User, bool> usersAndState = new Map();
    group.users.forEach((uid) {
      usersAndState.addEntries([
        MapEntry<User, bool>(
            User(name: "Den Namen bekommen wir nicht her", uid: uid),
            group.admins.contains(uid))
      ]);
    });
    if (group.admins.contains(userId)) {
      List<User> requestedToJoin = [];
      group.requestedToJoin.forEach((uid) {
        requestedToJoin
            .add(User(name: "Den Namen bekommen wir nicht her", uid: uid));
      });
      emit(AdminSettings()
        ..usersAndState = usersAndState
        ..group = group
        ..requestedToJoin = requestedToJoin);
    } else if (group.users.contains(userId)) {
      emit(MemberSettings()
        ..group = group
        ..usersAndState = usersAndState);
    }
  }
}
