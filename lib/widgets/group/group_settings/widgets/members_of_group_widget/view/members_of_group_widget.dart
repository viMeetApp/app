import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/members_of_group_controller.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/widgets/expandable_list.dart';

class MembersOfGroupWidget extends StatelessWidget {
  final Group group;

  MembersOfGroupWidget({required this.group});
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MembersOfGroupController(group: group),
      child: ExpandableList(
        members: group.members,
      ),
    );
  }
}
