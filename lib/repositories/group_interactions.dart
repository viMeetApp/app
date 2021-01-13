import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/util/data_models.dart';

//ToDo Implement Pagiantion

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

typedef void OnGroupReceived(Group group);
typedef void OnResponse(bool success);

class GroupInteractions {
  static getGroupInfo(String groupID, OnGroupReceived onGroupReceived) {
    _firestore
        .collection('groups')
        .doc(groupID)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        onGroupReceived(Group.fromDoc(documentSnapshot));
      }
    });
  }

  static joinGroup(String groupID, OnResponse onResponse) {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'requestToJoinGroup',
    );
    return callable
        .call(<String, dynamic>{'groupId': groupID})
        .then((value) => onResponse(true))
        .catchError((err) => onResponse(false));
  }
}
