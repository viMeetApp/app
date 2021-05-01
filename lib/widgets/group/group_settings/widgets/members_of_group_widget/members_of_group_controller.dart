import 'package:cloud_functions/cloud_functions.dart';
import 'package:signup_app/util/models/data_models.dart';

class MembersOfGroupController {
  final Group group;

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;

  MembersOfGroupController({required this.group});

  Future<void> promoteUserToAdmin(GroupUserReference userReference) async {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-promoteUserToAdmin',
    );
    await callable.call(
        {'groupId': group.id, 'user': userReference.toMap(includeID: true)});
  }

  Future<void> removeUserFromGroup(GroupUserReference userReference) async {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-removeUserFromGroup',
    );
    await callable.call(
        {'groupId': group.id, 'user': userReference.toMap(includeID: true)});
  }
}
