import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

class AdminssionToGroupController {
  final GroupRepository _groupRepository = new GroupRepository();
  final Group group;

  AdminssionToGroupController({required this.group});

  void acceptUser({required UserReference user}) {
    GroupUserReference groupUserReference = new GroupUserReference(
        name: user.name, id: user.id, isAdmin: false, picture: user.picture);
    group.members.add(groupUserReference);
    group.requestedToJoin!.remove(user);

    //todo Error Handling
    _groupRepository.updateGroup(group);
  }

  void declineUser({required UserReference user}) {
    group.requestedToJoin!.remove(user);
    //todo Error Handling
    _groupRepository.updateGroup(group);
  }
}
