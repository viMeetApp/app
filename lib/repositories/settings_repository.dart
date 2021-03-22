import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/data_models.dart' as util;

class SettingsRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  SettingsRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  ///Create a new User with dynamic userId and [name]

  ///Return the User who is currently authenticated
  Stream<util.User> observeUser() {
    return new UserRepository().observeUser();
  }

  Future<bool> setUserName(String name) async {
    try {
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({'name': name});
      return true;
    } catch (err) {
      print("Error while changing the users name");
    }
    return false;
  }
}
