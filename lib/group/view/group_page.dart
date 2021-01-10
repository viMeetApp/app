import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/cubit/group_cubit.dart';
import 'package:signup_app/group/view/group_page_content.dart';
import 'package:signup_app/junk/notMember_page.dart';
import 'package:signup_app/util/data_models.dart';

///Start Page For Group from here on decission if Member or not
class GroupPage extends StatelessWidget {
  final Group group;
  //Group is starter with an group because we already know the Group at this Position
  //Because of that we loose one fetch from Backend
  GroupPage({@required this.group});

  static Route route({@required Group group}) {
    return MaterialPageRoute<void>(
      builder: (_) => GroupPage(
        group: group,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupCubit>(
      create: (_) => GroupCubit(group: group),
      child: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          return Scaffold(body: GroupPageContent(state: state));
          /*if (state is GroupMember) {
            return GroupMemberPage(state: state);
          } else if (state is NotGroupMember) {
            return NotGroupMemberPage(state: state);
          } else if (state is GroupAdmin) {
          } else {
            //Uninitialized

          }*/
        },
      ),
    );
  }
}
