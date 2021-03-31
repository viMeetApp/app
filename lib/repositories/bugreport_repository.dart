import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/models/data_models.dart';

class BugReportRepository {
  final FirebaseFirestore _firestore;
  late CollectionReference _collectionReference;

  BugReportRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _collectionReference = _firestore.collection('bugreports');
  }

  ///Create c chat BugReport in firebase
  Future<void> createBugReport({required BugReport bugReport}) async {
    try {
      await _collectionReference
          .add(bugReport.toDoc()!)
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw Exception("connection timed out");
      });
    } catch (err) {
      throw err;
    }
  }
}
