import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/models/data_models.dart' as models;
import 'package:signup_app/util/tools/debug_tools.dart';

///Service for handling all Authetication
///
///Is instatiated as a Singleton
class AuthenticationService {
  static final AuthenticationService _authenticationService =
      AuthenticationService._privateConstructor();
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final UserRepository _userRepository;
  final StreamController<models.User> _currentUserStreamController =
      new StreamController<models.User>.broadcast();

  models.User? _currentUser;

  factory AuthenticationService() {
    return _authenticationService;
  }

  // Getters
  models.User getCurrentUser() {
    if (_currentUser == null) return throw Exception('Current User is null');
    return _currentUser!;
  }

  models.UserReference getCurrentUserReference() {
    models.User user = getCurrentUser();
    return models.UserReference(
        name: user.name, id: user.id, picture: user.picture);
  }

  Stream<models.User> getCurrentUserStream() {
    return _currentUserStreamController.stream;
  }

  /// Since Broadcast Stream dont buffer values it is imporant to emit new value when new Stream Listener has been connected
  void updateAfterNewListenerSubscibed() {
    if (_currentUser != null) {
      _currentUserStreamController.add(_currentUser!);
    }
  }

  String getCurrentUserUid() {
    return getCurrentUser().id;
  }

  /// Observes User referenced by [uid] to guarantee member variables [_currentUser] and [currentUserReference] are always up to date
  _observeCurrentAuthenticatedUser(String uid) {
    _firestore.collection('users').doc(uid).snapshots().forEach((userDoc) {
      _currentUser = models.User.fromDoc(userDoc);
      _currentUserStreamController.add(_currentUser!);
    });
  }

  /// Check if User isSIgnedIn if so _currentUser is set to real values and true returned
  Future<bool> isSignedIn() async {
    String? currentUserId = _firebaseAuth.currentUser?.uid;

    if (currentUserId == null) return false;

    try {
      models.User? firestoreUser =
          await _userRepository.getUserById(currentUserId);
      // Set local user Variables
      _currentUser = firestoreUser;
      _currentUserStreamController.add(_currentUser!);

      // Start observing
      _observeCurrentAuthenticatedUser(_currentUser!.id);
      return true;
    } catch (err) {
      viLog(err, 'Error in isSignedIn Method');
      //ToDO Wenn hier ein Fehler auftritt ist es sehr dumm, eigentlich sollte man eine NAchricht anzeigen und uns intern eine Mail senden
      //ToDo Es kann halt nicht sein das ein User existier aber kein Dokument
      exit(0);
    }
  }

  /// let the user sign up inside the app using a name
  /// [name] the display name of the user
  Future<void> signUpAnonymously(String name) async {
    if (name.length == 0)
      throw Exception(
          "Can't Create User. Name must be at leas 1 character long");

    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    if (userCredential.user?.uid == null)
      throw Exception(
          'Anaonymous SignUp failed, provided User does not contain Id');
    await _userRepository.createNewUserDoc(userCredential.user!.uid, name);
    return;
  }

  AuthenticationService._privateConstructor(
      {FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firestore,
      UserRepository? userRepository})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _userRepository = userRepository ?? UserRepository();
}
