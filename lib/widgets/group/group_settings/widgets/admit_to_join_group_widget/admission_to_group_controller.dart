import 'package:cloud_functions/cloud_functions.dart';
import 'package:signup_app/util/models/data_models.dart';

class AdminssionToGroupController {
  final Group group;

  AdminssionToGroupController({required this.group});

  final FirebaseFunctions _firebaseFunctions = FirebaseFunctions.instance;
  void acceptUser({required UserReference user}) {
    //ToDo Error Handling
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-acceptUserToGroup',
    );
    callable.call({'groupId': group.id, 'user': user.toMap(includeID: true)});
  }

  void declineUser({required UserReference user}) {
    // toDo Error Handling
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-declineUserFromGroup',
    );
    callable.call({'groupId': group.id, 'user': user.toMap(includeID: true)});
  }
}
