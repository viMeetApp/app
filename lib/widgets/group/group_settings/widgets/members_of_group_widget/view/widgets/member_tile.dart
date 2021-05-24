import 'package:flutter/material.dart';
import 'package:signup_app/repositories/group_interactions.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/common.dart';

import 'package:provider/provider.dart';

class MemberTile extends StatelessWidget {
  final AuthenticationService _authService;

  final GroupUserReference user;
  final bool currentUserIsAdmin;

  MemberTile(
      {required this.user,
      required this.currentUserIsAdmin,
      AuthenticationService? authenticationService})
      : _authService = authenticationService ?? AuthenticationService();
  Widget build(BuildContext context) {
    final GroupInteractions _groupInteactions =
        GroupInteractions(group: context.read<Group>());
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
                Tools.showSnackbar(context, "TODO: modify admins");
              },
            ),
          // Only Display delete button if current User is Admin and if displayed user is not user himself
          if (currentUserIsAdmin &&
              user.id != _authService.getCurrentUserReference().id)
            ViNetworkIconButton(
              onPressed: () => _groupInteactions.removeUserFromGroup(user),
              icon: Icon(Icons.close),
            )
        ],
      ),
    );
  }
}
