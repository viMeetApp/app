import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/util/data_models.dart' as util;

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseAuth firebaseAuth, FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  ///Create a new User with dynamic userId and [name]
  Future<void> signUpAnonymously(String name) async {
    //! ToDO Was passiert, wenn user zwar erzeugt wird in Firebase, aber schreiben in Model schiefläuft
    try {
      //Check for Error in Name
      if (name == null || name.length == 0)
        throw ("Can't Create User, Name Invalid");
      //Create User in Firebase
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      //Create matching user model in DB
      await _firestore
          .collection('users')
          .doc(userCredential.user.uid)
          .set({'name': name, 'uid': userCredential.user.uid});
    } catch (err) {
      print("Error Sign Up Anonymously");
      print(err.toString());
    }
  }

  ///Return the User who is currently authenticated
  Future<util.User> getUser() async {
    try {
      var snap = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .get();
      return util.User.fromJson(snap.data());
    } catch (err) {
      print("Error in get User");
      print(err.toString());
    }
  }

  ///Is the Device already Signed In
  bool isSignedIn() {
    return _firebaseAuth.currentUser != null;
  }
}
