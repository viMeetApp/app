import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/util/models/data_models.dart';

class GroupRepository {
  final FirebaseFirestore _firestore;
  late CollectionReference _groupCollectionReference;

  GroupRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _groupCollectionReference = _firestore.collection('groups');
  }

  ///Creates a [group] Object in Firestore
  Future<void> createGroup(Group group) async {
    try {
      await _groupCollectionReference.add(group.toMap());
    } catch (err) {
      throw err;
    }
  }

  ///Updates [group] Object in Firestore
  Future<void> updateGroup(Group group) async {
    try {
      assert(group.id != '',
          'When updating a Group, Object must contain a valid Id');
      await _groupCollectionReference.doc(group.id).update(group.toMap());
    } catch (err) {
      throw err;
    }
  }

  ///Returns a Stream (real Time Updates) of a Group specified by [groupId]
  Stream<Group> getGroupStreamById(String groupId) {
    return _groupCollectionReference
        .doc(groupId)
        .snapshots()
        .map((DocumentSnapshot doc) => Group.fromDoc(doc));
  }
}
