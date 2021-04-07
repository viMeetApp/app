import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

part 'group_settings_state.dart';

class GroupSettingsCubit extends Cubit<GroupMemberSettings> {
  final userId = fire.FirebaseAuth.instance.currentUser!.uid;
  final GroupRepository _groupRepository = new GroupRepository();

  GroupSettingsCubit({required Group group})
      : super(GroupMemberSettings(group: group)) {
    _checkAndEmitMatchingState(group: group);

    //ensures real time updates of the group
    _groupRepository
        .getGroupStreamById(group.id)
        .listen((Group group) => _checkAndEmitMatchingState(group: group));
  }

  ///Update Settings of Group only valid if admin
  Future<void> updateGroup(
      {required Group group, required BuildContext ctx}) async {
    //Save before state to make reset possible when Network Fails
    Group oldGroup = state.group;
    if (state is AdminSettings) {
      emit(AdminSettings(group: group));
      _groupRepository.updateGroup(group).then((_) {
        Scaffold.of(ctx)
            .showSnackBar(SnackBar(content: Text("Update Erfolgreich")));
      }).catchError((err) {
        Scaffold.of(ctx).hideCurrentSnackBar();
        Scaffold.of(ctx)
            .showSnackBar(SnackBar(content: Text("Netzwerkfehler")));

        //If update Fails reset the fields
        emit(AdminSettings(group: oldGroup));
      });
    } else {
      log("Your are not allowed to change Group Settings, Must be Admin");
    }
  }

  ///Accept Request for New Group Memeber, onyly Admmins allowed
  void accepRequest({required User user}) {
    if (state is AdminSettings) {
      _groupRepository.updateGroupViaQuery(state.group, {
        'requestedToJoin': FieldValue.arrayRemove([user.id]),
        'users': FieldValue.arrayUnion([user.id])
      }).then((Group group) {
        emit(AdminSettings(group: group));
      }); //ToDo Error Handling
    }
  }

  ///Decline Request for New Group Memeber, onyly Admmins allowed
  void declineRequest({required User user}) {
    if (state is AdminSettings) {
      _groupRepository.updateGroupViaQuery(state.group, {
        'requestedToJoin': FieldValue.arrayRemove([user.id])
      }).then((Group group) {
        emit(AdminSettings(group: group));
      }); //ToDo Error Handling
    }
  }

  ///Helper Function, Decides if person is Admin of Group or just basic Member
  void _checkAndEmitMatchingState({required Group group}) {
    GroupUserReference selfReference =
        group.members.firstWhere((member) => member.id == userId);
    if (selfReference.isAdmin) {
      return emit(AdminSettings(group: group));
    } else
      return emit(GroupMemberSettings(group: group));
  }

//ToDo Extract Cloud Function logic
  ///Unsunscribe User from Group via own Cloud Function
  Future unsubscribeFromGroup() {
    log('unsubscribing');
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'unsubscribeFromGroup',
    );
    return callable
        .call(<String, dynamic>{'groupId': state.group.id})
        .then((value) => print("Unsubscribed Sucessfully"))
        .catchError((err) => {
              // emit(SubscriptionState.onError()),
              print("There was an error unsubscribing" + err.toString())
            });
  }
}
