import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';

class MemberTile extends StatelessWidget {
  final User user;
  final bool? userHasAdminRights;

  MemberTile({required this.user, this.userHasAdminRights});
  Widget build(BuildContext context) {
    final isAdmin = BlocProvider.of<GroupSettingsCubit>(context)
        .state
        .group
        .admins!
        .contains(user.id);
    return ListTile(
      leading: Icon(Icons.account_circle),
      title: Text(user.name!),
      trailing: Wrap(
        children: [
          if (isAdmin)
            IconButton(
                icon: Icon(Icons.verified_user),
                padding: EdgeInsets.only(left: 10),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("TODO: modify admins")));
                }),
          if (userHasAdminRights!)
            IconButton(
                icon: Icon(Icons.close),
                padding: EdgeInsets.only(left: 10),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("TODO: remove user")));
                }),
        ],
      ),
    );
  }
}
