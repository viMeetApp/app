import 'package:cloud_functions/cloud_functions.dart';
import 'package:signup_app/util/models/data_models.dart';

class AdminssionToGroupController {
  final Group group;

  AdminssionToGroupController({required this.group});

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;
  Future<void> acceptUser({required UserReference user}) async {
    //ToDo Error Handling
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-acceptUserToGroup',
    );
    await callable
        .call({'groupId': group.id, 'user': user.toMap(includeID: true)});
  }

  Future<void> declineUser({required UserReference user}) async {
    // toDo Error Handling
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-declineUserFromGroup',
    );
    await callable
        .call({'groupId': group.id, 'user': user.toMap(includeID: true)});
  }
}
