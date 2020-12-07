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

  Future<void> createUserIfNotExisitent() async {
    if (_firebaseAuth.currentUser != null) {
      return;
    }
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    //Create matching user model in DB
    await _firestore
        .collection('users')
        .doc(userCredential.user.uid)
        .set({'name': null, 'uid': userCredential.user.uid});
  }

  Future<void> signUpAnonymously(String name) async {
    //! ToDO Was passiert, wenn user zwar erzeugt wird in Firebase, aber schreiben in Model schiefläuft
    try {
      //Check for Error in Name
      if (name == null || name.length == 0)
        throw ("Can't Create User, Name Invalid");
      //Create User in Firebase
      _firebaseAuth.currentUser.updateProfile(displayName: name);
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .set({'name': name});
    } catch (err) {
      print("Error Sign Up Anonymously");
      print(err.toString());
    }
  }

  Stream<List<util.User>> getUsersWithMatchingId(List<String> userIds) {
    Stream<List<util.User>> userStream = _firestore
        .collection('users')
        .where('uid', whereIn: userIds)
        .snapshots()
        .map((list) => list.docs.map((doc) => util.User.fromDoc(doc)));
    return userStream;
  }

  ///Return the User who is currently authenticated
  Future<util.User> getUser() async {
    try {
      var snap = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .get();
      print(util.User.fromDoc(snap).toMap());
      return util.User.fromDoc(snap);
    } catch (err) {
      print("Error in get User");
      print(err.toString());
    }
  }

  ///Is the Device already Signed In
  bool isSignedIn() {
    if (_firebaseAuth.currentUser == null ||
        _firebaseAuth.currentUser.uid == null) {
      return false;
    }
    // ich nutze hier den 'displayName', da für eine Abfrage der Datenbank ein
    // größerer Zeitaufwand & asynchrone Methoden nötig wären
    if (_firebaseAuth.currentUser.displayName != null) {
      return true;
    }
    return false;
  }
}
