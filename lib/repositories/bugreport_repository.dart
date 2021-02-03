import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';

class BugReportRepository {
  final FirebaseFirestore _firestore;
  CollectionReference _postCollectionReference;

  BugReportRepository({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _postCollectionReference = _firestore.collection('bugreports');
  }

  ///Create c chat BugReport in firebase
  Future<void> createChatMessage({@required BugReport bugReport}) async {
    try {
      await _postCollectionReference.add(bugReport.toDoc());
    } catch (err) {
      throw err;
    }
  }
}
