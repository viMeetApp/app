import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

part 'group_list_state.dart';

class GroupListCubit extends Cubit<Stream<List<Group>>> {
  GroupListCubit() : super(Stream.empty()) {
    Stream<List<Group>> groupStream =
        GroupRepository().getStreamOfMemberGroups();
    emit(groupStream);
  }
}
