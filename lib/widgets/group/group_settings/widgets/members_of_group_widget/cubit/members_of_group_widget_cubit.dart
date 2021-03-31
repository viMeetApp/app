import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

part 'members_of_group_widget_state.dart';

class MembersOfGroupWidgetCubit extends Cubit<List<User>> {
  final _groupRepository = new GroupRepository();
  StreamSubscription? _streamSubscription;
  late Stream<List<User>> currentStream;
  MembersOfGroupWidgetCubit({required Group group}) : super([]) {
    updateStreamSubscription(group);
  }

  //Needs to be called when grou.users Changes
  //Then this function cancels old (invalid) stream subscription
  //and renews subscription with a new one
  void updateStreamSubscription(Group group) async {
    if (_streamSubscription != null) {
      await _streamSubscription!.cancel();
    }
    if (group.users!.length == 0) {
      emit([]);
    } else {
      currentStream =
          _groupRepository.getStreamOfUsersWhichAreCurrentyMemberOfGroup(group);
      _streamSubscription = currentStream.listen((List<User> users) {
        emit(users);
      });
    }
  }
}
