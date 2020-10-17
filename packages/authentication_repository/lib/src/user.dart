import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///User Model
class User {
  const User({
    @required this.name,
    @required this.userid
  }):assert(userid!=null), assert(name!=null);

  final String name;
  final String userid;

  ///Create a User from a Firestore User Snapshot.
  User.fronSnapshot(DocumentSnapshot snap):
  userid=snap['userid'], name=snap['name'];
}