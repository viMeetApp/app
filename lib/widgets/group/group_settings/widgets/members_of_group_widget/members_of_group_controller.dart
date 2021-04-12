import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

class MembersOfGroupController {
  final GroupRepository _groupRepository = new GroupRepository();
  final Group group;

  MembersOfGroupController({required this.group});

  void promoteUserToAdmin(GroupUserReference userReference) {
    final currentUser =
        group.members.firstWhere((user) => user.id == userReference.id);
    currentUser.isAdmin = true;
    _groupRepository.updateGroup(group);
  }

  void removeUserFromGroup(GroupUserReference userReference) {
    final currentUser =
        group.members.firstWhere((user) => user.id == userReference.id);
    group.members.remove(currentUser);
    _groupRepository.updateGroup(group);
  }
}
