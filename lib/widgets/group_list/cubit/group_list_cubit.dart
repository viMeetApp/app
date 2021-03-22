import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/util/data_models.dart';

part 'group_list_state.dart';

class GroupListCubit extends Cubit<Stream<List<Group>>> {
  GroupListCubit() : super(Stream.empty()) {
    Stream<List<Group>> groupStream = _getPersonalGroupStreamFromFirestore();
    emit(groupStream);
  }
  Stream<List<Group>> _getPersonalGroupStreamFromFirestore() {
    return FirebaseFirestore.instance
        .collection('groups')
        .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((list) => list.docs.map((doc) => (Group.fromDoc(doc))).toList());
  }
}
