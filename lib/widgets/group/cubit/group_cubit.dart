import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/data_models.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final userId = FirebaseAuth.instance.currentUser.uid;
  final GroupRepository _groupRepository = new GroupRepository();
  GroupCubit({@required Group group}) : super(GroupUninitialized()) {
    _checkAndEmitGroupState(group);
    //Im ersten Schritt wird Bloc mit einer geladenen Gruppe versorgt,
    //um aber dynamisches zu behalten wird gleichzeitig verbindung zu Firestore aufgebaut
    //um ab da dynamische Gruppe zu haben.
    _groupRepository
        .getGroupStreamById(group.id)
        .listen((Group group) => _checkAndEmitGroupState(group));
  }

  Future requestToJoinGroup() {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'requestToJoinGroup',
    );
    return callable
        .call(<String, dynamic>{'groupId': state.group.id})
        .then((value) => print("Subscribed Sucessfully"))
        .catchError((err) => {
              // emit(SubscriptionState.onError()),
              print("There was an error subscribing" + err.toString())
            });
  }

  void _checkAndEmitGroupState(Group group) {
    if (group.admins.contains(userId)) {
      emit(GroupAdmin(group: group));
    } else if (group.users.contains(userId)) {
      emit(GroupMember(group: group));
    } else {
      emit(NotGroupMember(group: group));
    }
  }
}
