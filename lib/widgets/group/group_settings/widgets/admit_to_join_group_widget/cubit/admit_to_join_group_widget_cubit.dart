import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/data_models.dart';

part 'admit_to_join_group_widget_state.dart';

class AdmitToJoinGroupWidgetCubit extends Cubit<List<User>> {
  final _groupRepository = new GroupRepository();
  StreamSubscription _streamSubscription;
  Stream<List<User>> currentStream;
  AdmitToJoinGroupWidgetCubit({@required Group group}) : super([]) {
    updateStreamSubscription(group);
  }

  //Needs to be called when requestedToJoin Changes
  //Then this function cances old (invalid) stream subscriptio
  //and renews subscription with a new one
  void updateStreamSubscription(Group group) async {
    if (_streamSubscription != null) {
      await _streamSubscription.cancel();
    }
    //In case there is no one to subscribe just return empty List of users (no Stream)
    if (group.requestedToJoin.length == 0) {
      emit([]);
    } else {
      currentStream =
          _groupRepository.getStreamOfUsersRequestingToJoinAGroup(group);
      _streamSubscription = currentStream.listen((List<User> users) {
        emit(users);
      });
    }
  }
}
