import 'package:flutter/material.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/members_of_group_controller.dart';
import 'package:provider/provider.dart';

class MemberTile extends StatelessWidget {
  final GroupUserReference user;
  final bool currentUserIsAdmin;

  MemberTile({
    required this.user,
    required this.currentUserIsAdmin,
  });
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text(user.name),
      trailing: Wrap(
        children: [
          if (user.isAdmin)
            IconButton(
                icon: Icon(Icons.verified_user),
                padding: EdgeInsets.only(left: 10),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("TODO: modify admins")));
                }),
          // Only Display delete button if current User is Admin and if displayed user is not user himself
          if (currentUserIsAdmin &&
              user.id != UserRepository().getUserReference()?.id)
            IconButton(
                icon: Icon(Icons.close),
                padding: EdgeInsets.only(left: 10),
                onPressed: () {
                  context
                      .read<MembersOfGroupController>()
                      .removeUserFromGroup(user);
                }),
        ],
      ),
    );
  }
}
