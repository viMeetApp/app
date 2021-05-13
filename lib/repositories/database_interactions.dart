import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/common.dart';

enum DBActionError { timedOut, permissions, unknownError }

class DBInteractions {
  static const COLL_BUGREPORTS = "bugreports";
  static const COLL_GROUPS = "groups";
  static const COLL_POSTS = "posts";
  static const COLL_REPORTS = "reports";
  static const COLL_USERS = "users";

  final FirebaseFirestore _firestore;

  DBInteractions({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // save a document to firestore, returns ID
  Future<String> setDocument(
      {required String collection, required DatabaseDocument document}) async {
    try {
      DocumentReference ref = await _firestore
          .collection(collection)
          .add(document.toMap())
          .timeout(Duration(seconds: 5),
              onTimeout: () => throw Exception(DBActionError.timedOut))
          .onError((error, stackTrace) =>
              throw Exception(DBActionError.unknownError))
          .catchError((error, stackTrace) =>
              throw Exception(DBActionError.unknownError));
      return ref.id;
    } catch (e) {
      throw Exception(DBActionError.unknownError);
    }
  }
}
