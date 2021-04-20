import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';

class SettingsRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  SettingsRepository(
      {FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firestore,
      AuthenticationService? authenticationService})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  ///Create a new User with dynamic userId and [name]

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
