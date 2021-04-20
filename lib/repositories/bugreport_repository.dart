import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/repositories/database_interactions.dart';
import 'package:signup_app/util/models/data_models.dart';

class BugReportRepository {
  DBInteractions _dbInteractions = DBInteractions();

  /// Create c chat BugReport in firebase
  Future<String> createBugReport({required BugReport bugReport}) async {
    try {
      return await _dbInteractions.setDocument(
          collection: DBInteractions.COLL_BUGREPORTS, document: bugReport);
    } catch (e) {
      return "";
    }
  }
}
