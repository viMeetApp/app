import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/group/cubit/group_cubit.dart';
import 'package:signup_app/util/data_models.dart';

part 'group_seetings_state.dart';

class GroupSeetingsCubit extends Cubit<GroupMemberSettings> {
  final userId = fire.FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GroupSeetingsCubit({@required Group group})
      : super(GroupMemberSettings(group: group)) {
    //Defaults to member Settings but can change quick
    _checkAndEmitMatchingState(group: group);
  }

  ///Update Settings of Group only valid if admin
  Future<void> updateGroup(
      {@required Group group, @required BuildContext ctx}) async {
    Group oldGroup = state.group;
    if (state is AdminSettings) {
      emit(AdminSettings(group: group));
      _firestore
          .collection('groups')
          .doc(state.group.id)
          .update(group.toJson())
          .then((_) {
        Scaffold.of(ctx)
            .showSnackBar(SnackBar(content: Text("Update Erfolgreich")));
      }).catchError((err) {
        Scaffold.of(ctx).hideCurrentSnackBar();
        Scaffold.of(ctx)
            .showSnackBar(SnackBar(content: Text("Netzwerkfehler")));
        log("Error updating Group");
        log(err);
        //If update Fails reset the fields
        emit(AdminSettings(group: oldGroup));
      });
    } else {
      log("Your are not allowed to change Group Settings, Must be Admin");
    }
  }

  ///Accept Request for New Group Memeber, onyly Admmins allowed
  void accepRequest({@required User user}) {
    if (state is AdminSettings) {
      state.group.requestedToJoin.remove(user.uid);
      state.group.users.add(user.uid);
      var ref = _firestore.collection('groups').doc(state.group.id);
      ref.update(state.group.toJson()).then((value) {
        AdminSettings(group: state.group);
      }).catchError((err) => log("Error"));
    }
  }

  ///Decline Request for New Group Memeber, onyly Admmins allowed
  void declineRequest({@required User user}) {
    if (state is AdminSettings) {
      state.group.requestedToJoin.remove(user.uid);
      var ref = _firestore.collection('groups').doc(state.group.id);
      ref.update(state.group.toJson()).then((value) {
        AdminSettings(group: state.group);
      }).catchError((err) => log("Error"));
    }
  }

  ///Helper Function, Decides if person is Admin of Group or just basic Member
  void _checkAndEmitMatchingState({Group group}) {
    //Create User and State Map
    if (group.admins.contains(userId)) {
      emit(AdminSettings(group: group));
    } else if (group.users.contains(userId)) {
      emit(GroupMemberSettings(group: group));
    }
  }
}
