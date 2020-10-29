import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/util/data_models.dart';

part 'group_dropdown_state.dart';

class GroupDropdownCubit extends Cubit<Stream<List<Group>>> {
  GroupDropdownCubit() : super(Stream.empty()) {
    //Fetch all Groups from Firestore
    Stream<List<Group>> groupStream = FirebaseFirestore.instance
        .collection('groups')
        .where('users', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map((list) => list.docs
            .map((doc) => Group.fromJson(doc.data()).setID(doc.id))
            .toList());
    emit(groupStream);
  }
}
