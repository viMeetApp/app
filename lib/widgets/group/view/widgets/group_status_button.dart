import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/group/cubit/group_cubit.dart';

import 'group_cancel_group_join_request_dialog.dart';

///Button which changes form and use depending on status. [join group, leave group, abort request]
class GroupStatusButton extends StatelessWidget {
  const GroupStatusButton();
  @override
  Widget build(BuildContext context) {
    final GroupCubit _cubit = BlocProvider.of<GroupCubit>(context);
    if (_cubit.state is NotGroupMember)
      return (_cubit.state as NotGroupMember).requestedToJoin
          ? OutlinedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        CancelGroupJoinRequestDialog());
              },
              child: Text("angefragt"),
              // style: AppThemeData.viOutlinedButtonStyle,
            )
          : ViNetworkElevatedButton(
              onPressed: () =>
                  BlocProvider.of<GroupCubit>(context).requestToJoinGroup(),
              child: Text("beitreten"),
            );
    else
      return ViNetworkOutlinedButton(
        onPressed: () => BlocProvider.of<GroupCubit>(context).leaveGroup(),
        child: Text("austreten"),
      );
  }
}
