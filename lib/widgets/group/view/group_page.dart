import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/widgets/group/cubit/group_cubit.dart';
import 'package:signup_app/widgets/group/view/widgets/group_page_content.dart';

///Start Page For Group from here on decission if Member or not
class GroupPage extends StatelessWidget {
  final Group? group;
  //Group is starter with an group because we already know the Group at this Position
  //Because of that we loose one fetch from Backend
  GroupPage({required this.group});

  static Route route({required Group? group}) {
    return MaterialPageRoute<void>(
      builder: (_) => GroupPage(
        group: group,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupCubit>(
      create: (_) => GroupCubit(group: group!),
      child: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          return Scaffold(body: GroupPageContent(state: state));
        },
      ),
    );
  }
}
