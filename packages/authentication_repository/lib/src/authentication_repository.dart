import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart' as myUser;

///Repository has mainly two Functions
///1. Get Authenticated State and SignUp a User.
///2. Return User Information
class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthenticationRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  ///Create a new User with dynamic userId and [name]
  Future<void> signUpAnonymously(String name)async{
    //! ToDO Was passiert, wenn user zwar erzeugt wird in Firebase, aber schreiben in Model schiefläuft
    try{
      //Check for Error in Name
      if(name==null||name.length==0) throw("Can't Create User, Name Invalid");
      //Create User in Firebase
      UserCredential userCredential=await _firebaseAuth.signInAnonymously();
      //Create matching user model in DB
      await _firestore.collection('users').doc(userCredential.user.uid).set({
        'name':name,
        'userid':userCredential.user.uid
      });
    }
    catch(err){
      print("Error Sign Up Anonymously");
      print(err.toString());
    }
  }
  ///Return the User who is currently authenticated
  Future<myUser.User> getUser()async{
    try{
    var snap=await _firestore.collection('users').doc(_firebaseAuth.currentUser.uid).get();
    return myUser.User.fronSnapshot(snap);}
    catch(err){
      print("Error in get User");
      print(err.toString());
    }
  }
  ///Is the Device already Signed In
  bool isSignedIn(){
    return _firebaseAuth.currentUser!=null;
  }
}
