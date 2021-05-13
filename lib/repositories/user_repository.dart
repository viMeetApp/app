import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/util/models/data_models.dart' as util;
import 'package:signup_app/common.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<util.User> getUserById(String userId) async {
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(userId).get();
    if (snap.data() == null)
      throw ViServiceException('There is no User present with matching Id');
    return util.User.fromDoc(snap);
  }

  Future<util.User> getUserFromDatabase() async {
    try {
      var snap = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      return util.User.fromDoc(snap);
    } catch (err) {
      print("Error in get User");
      print(err.toString());
      throw err;
    }
  }

  /// internal function to create a document for an auth user
  /// [uid] the uid of the auth user
  /// [name] the display name of the user
  Future<void> createNewUserDoc(String uid, String name) async {
    //Create matching user model in DB
    await _firestore
        .collection('users')
        .doc(uid)
        .set(util.User(name: name, id: uid).toMap());
  }
}
