import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/util/data_models.dart';

//ToDo Implement Pagiantion

class GroupPagination {
  ///Return all Groups the current User is part of
  static Stream<List<Group>> getSubscribedGroups() {
    Stream<List<Group>> groupStream = FirebaseFirestore.instance
        .collection('groups')
        .where('users', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map((list) => list.docs.map((doc) => (Group.fromDoc(doc))).toList());

    return groupStream;
  }

  ///Return all Groups the current User is not part of
  static Stream<List<Group>> getNewGroups() {
    Stream<List<Group>> groupStream = FirebaseFirestore.instance
        .collection('groups')
        .snapshots()
        .map((list) => list.docs
            .where((doc) {
              Group group = Group.fromDoc(doc);
              return !group.users
                  .contains(FirebaseAuth.instance.currentUser.uid);
            })
            .map((doc) => (Group.fromDoc(doc)))
            .toList());

    return groupStream;
  }
}
