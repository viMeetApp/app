import 'package:cloud_functions/cloud_functions.dart';
import 'package:signup_app/common.dart';

class GroupInteractions {
  final Group _group;
  final FirebaseFunctions _firebaseFunctions;
  GroupInteractions(
      {FirebaseFunctions? firebaseFunctions, required Group group})
      : _firebaseFunctions = firebaseFunctions ??
            FirebaseFunctions.instanceFor(region: 'europe-west3'),
        _group = group;

  Future<void> joinGroup() {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-requestToJoinGroup',
    );

    return callable.call(_group.id);
  }

  Future<void> leaveGroup() {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-leaveGroup',
    );

    return callable.call(_group.id);
  }

  Future<void> abortJoinRequest() {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-abortJoinRequest',
    );

    return callable.call(_group.id);
  }

  Future<void> promoteUserToAdmin(GroupUserReference userReference) {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-promoteUserToAdmin',
    );
    return callable.call(
        {'groupId': _group.id, 'user': userReference.toMap(includeID: true)});
  }

  Future<void> removeUserFromGroup(GroupUserReference userReference) {
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-removeUserFromGroup',
    );
    return callable.call(
        {'groupId': _group.id, 'user': userReference.toMap(includeID: true)});
  }

  Future<void> acceptUser({required UserReference user}) {
    //ToDo Error Handling
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-acceptUserToGroup',
    );
    return callable
        .call({'groupId': _group.id, 'user': user.toMap(includeID: true)});
  }

  Future<void> declineUser({required UserReference user}) {
    // toDo Error Handling
    HttpsCallable callable = _firebaseFunctions.httpsCallable(
      'groups-declineUserFromGroup',
    );
    return callable
        .call({'groupId': _group.id, 'user': user.toMap(includeID: true)});
  }
}
