import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/util/data_models.dart';

class GroupRepository {
  final FirebaseFirestore _firestore;
  CollectionReference _groupCollectionReference;

  GroupRepository({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _groupCollectionReference = _firestore.collection('groups');
  }

  ///Creates a [group] Object in Firestore
  Future<void> createGroup(Group group) async {
    try {
      await _groupCollectionReference.add(group.toDoc());
    } catch (err) {
      throw err;
    }
  }

  ///Updates [group] Object in Firestore
  Future<void> updateGroup(Group group) async {
    try {
      assert(group.id != null && group.id != '',
          'When updating a Group, Object must contain a valid Id');
      await _groupCollectionReference.doc(group.id).update(group.toDoc());
    } catch (err) {
      throw err;
    }
  }

  ///Updates [group] via an, due to more complicated outcome also return updated Group
  Future<Group> updateGroupViaQuery(
      Group group, Map<String, dynamic> query) async {
    try {
      assert(group.id != null && group.id != '',
          'When updating a Group, Object must contain a valid Id');
      await _groupCollectionReference.doc(group.id).update(query);
      Group updatedGroup = await getGroupDocumentById(group.id);
      return updatedGroup;
    } catch (err) {
      throw err;
    }
  }

  ///Returns a Group Document specified by [groupId]
  ///
  ///This function only returns a one Time Read
  Future<Group> getGroupDocumentById(String groupId) async {
    try {
      assert(
          groupId != null && groupId != '', 'A Valid groupId must be provided');
      DocumentSnapshot groupReference =
          await _groupCollectionReference.doc(groupId).get();
      Group group = Group.fromDoc(groupReference);
      return group;
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
