import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/util/models/data_models.dart' as util;

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  static util.User? _currentUser;

  UserRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  // user interactions

  /// Return the User who is currently authenticated
  Stream<util.User> observeUser() {
    return _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((DocumentSnapshot doc) => util.User.fromDoc(doc));
  }

  static String getUID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  /// Return the User who is currently authenticated
  util.User? getUser() {
    return _currentUser;
  }

  util.UserReference? getUserReference() {
    if (_currentUser != null) {
      return util.UserReference(
          name: _currentUser!.name,
          id: _currentUser!.id,
          picture: _currentUser!.picture);
    }
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

  Stream<List<util.User>> getUsersWithMatchingId(List<String> userIds) {
    Stream<List<util.User>> userStream = _firestore
        .collection('users')
        .where('uid', whereIn: userIds)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => util.User.fromDoc(doc)) as List<util.User>);
    return userStream;
  }

  // login functions

  /// check if the current user is authorized
  /// (has an account with firebase auth). This method also tries to create an
  /// account if none exists
  Future<bool> isAuthorized() async {
    return (await _createAuthUser()) != null;
  }

  /// check if the user is authorized and
  /// the user document exists in the database
  Future<bool> isSignedIn() async {
    String? uid = await _createAuthUser();

    if (uid == null) {
      return false;
    }

    if (!(await _firestore.collection('users').doc(uid).get()).exists) {
      return false;
    }
    _currentUser = await getUserFromDatabase();
    return true;
  }

  /// let the user sign up inside the app using a name
  /// [name] the display name of the user
  Future<void> signUpAnon(String name) async {
    if (name.length == 0) throw ("Can't Create User, Name Invalid");

    String? uid = await _createAuthUser();

    if (uid == null) {
      throw Exception("could not create auth user");
    }

    _createUserDoc(uid, name);
  }

  /// internal function to create a user with firebase auth.
  /// returns the uid of the created user
  Future<String?> _createAuthUser() async {
    // check if user already exists
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    }
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    // the following line does not seem to work for anonymous users
    //_firebaseAuth.currentUser!.updateProfile(displayName: name);
    return userCredential.user?.uid;
  }

  /// internal function to create a document for an auth user
  /// [uid] the uid of the auth user
  /// [name] the display name of the user
  Future<void> _createUserDoc(String uid, String name) async {
//Create matching user model in DB
    await _firestore
        .collection('users')
        .doc(uid)
        .set(util.User(name: name, id: uid).toMap());
  }

  /*Future<void> signUp() async {
    if (_firebaseAuth.currentUser != null) {
      return;
    }
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
  }

  Future<void> createUserDoc(String uid, String name) async {
    
  }

  Future<void> signUpAnonymously(String name) async {
    try {
      //Check for Error in Name
      if (name == null || name.length == 0)
        throw ("Can't Create User, Name Invalid");
      //Create User in Firebase
      
      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .set({'name': name});
    } catch (err) {
      print("Error Sign Up Anonymously");
      print(err.toString());
    }
  }
  ///Is the Device already Signed In
  bool isSignedIn() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    }

    // ich nutze hier den 'displayName', da für eine Abfrage der Datenbank ein
    // größerer Zeitaufwand & asynchrone Methoden nötig wären
    log("display name: ${_firebaseAuth.currentUser!.displayName}");
    if (_firebaseAuth.currentUser!.displayName != null) {
      return true;
    }
    return false;
  }*/
}
