import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/util/data_models.dart';

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
      await _groupCollectionReference.add(group.toDoc()!);
    } catch (err) {
      throw err;
    }
  }

  ///Updates [group] Object in Firestore
  Future<void> updateGroup(Group group) async {
    try {
      assert(group.id != null && group.id != '',
          'When updating a Group, Object must contain a valid Id');
      await _groupCollectionReference.doc(group.id).update(group.toDoc()!);
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
  Future<Group> getGroupDocumentById(String? groupId) async {
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
  Stream<Group> getGroupStreamById(String? groupId) {
    return _groupCollectionReference
        .doc(groupId)
        .snapshots()
        .map((DocumentSnapshot doc) => Group.fromDoc(doc));
  }

  ///Returns a stream of all users which are currently requesting to subscribe to a [group]
  Stream<List<User>> getStreamOfUsersRequestingToJoinAGroup(Group group) {
    if (group.requestedToJoin!.length == 0) {
      throw new Exception("requestedToJoin list is malformed. List is empty");
    } else {
      return _firestore
          .collection('users')
          .where('__name__', whereIn: group.requestedToJoin)
          .snapshots()
          .map((QuerySnapshot querySnapshot) =>
              querySnapshot.docs.map((doc) => User.fromDoc(doc)).toList());
    }
  }

  ///Returns a stream of alll users which are currently member of a [group]
  Stream<List<User>> getStreamOfUsersWhichAreCurrentyMemberOfGroup(
      Group group) {
    StreamController<List<User>> streamController =
        new StreamController<List<User>>();
    if (group.users!.length == 0) {
      throw new Exception("user list is malformed. List is empty");
    } else {
      List<List<User>> _allPagedResults = [];
      int requestIndex = 0;

      //Slice Array into chunk
      List<List<String>> chunks = [];
      int counter = 0;
      while (group.users!.length - counter > 10) {
        chunks.add(group.users!.sublist(counter, counter + 10));
        counter += 10;
      }
      chunks.add(group.users!.sublist(counter));

      chunks.forEach((List<String> userList) {
        int currentIndex = requestIndex;
        requestIndex++;
        _allPagedResults.add([]);
        _firestore
            .collection('users')
            .where('__name__', whereIn: userList)
            .snapshots()
            .listen((QuerySnapshot userListSnapshot) {
          if (userListSnapshot.docs.isNotEmpty) {
            List<User> users = userListSnapshot.docs
                .map((QueryDocumentSnapshot userDoc) => User.fromDoc(userDoc))
                .toList();
            _allPagedResults[currentIndex] = users;

            //Make one result out of all Sub User array
            List<User> allUsers = _allPagedResults.fold<List<User>>([],
                (initialValue, pageItems) => initialValue..addAll(pageItems));
            streamController.add(allUsers);
          }
        });
      });
    }
    return streamController.stream;
  }
}
