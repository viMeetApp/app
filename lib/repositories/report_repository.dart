import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';

class ReportRepository {
  final FirebaseFirestore _firestore;
  late CollectionReference _collectionReference;

  ReportRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _collectionReference = _firestore.collection('reports');
  }

  ///Create c chat BugReport in firebase
  Future<void> createReport({required Report report}) async {
    try {
      print("send");
      await _collectionReference
          .add(report.toDoc()!)
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw Exception("connection timed out");
      } as FutureOr<DocumentReference> Function()?);
    } catch (err) {
      print("error");
      throw err;
    }
  }
}
