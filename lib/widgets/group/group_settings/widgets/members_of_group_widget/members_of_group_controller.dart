import 'package:cloud_functions/cloud_functions.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

class MembersOfGroupController {
  final GroupRepository _groupRepository = new GroupRepository();
  final Group group;

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

  MembersOfGroupController({required this.group});

  void promoteUserToAdmin(GroupUserReference userReference) {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-promoteUserToAdmin',
    );
    callable.call(
        {'groupId': group.id, 'user': userReference.toMap(includeID: true)});
  }

  void removeUserFromGroup(GroupUserReference userReference) {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-removeUserFromGroup',
    );
    callable.call(
        {'groupId': group.id, 'user': userReference.toMap(includeID: true)});
  }
}
