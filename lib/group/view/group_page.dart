import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/cubit/group_cubit.dart';
import 'package:signup_app/group/view/group_member_page.dart';
import 'package:signup_app/group/view/notMember_page.dart';
import 'package:signup_app/util/data_models.dart';

class GroupPage extends StatelessWidget {
  final Group group;
  GroupPage({@required this.group});

  static Route route({@required Group group}) {
    return MaterialPageRoute<void>(
        builder: (_) => GroupPage(
              group: group,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupCubit>(
      create: (_) => GroupCubit(group: group),
      child: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          if (state is GroupMember) {
            return GroupMemberPage(state: state);
          } else if (state is NotGroupMember) {
            return NotGroupMemberPage(state: state);
          } else if (state is GroupAdmin) {
          } else {
            //Uninitialized

          }
        },
      ),
    );
  }
}
