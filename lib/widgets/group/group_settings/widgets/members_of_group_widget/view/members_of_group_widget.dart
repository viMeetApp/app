import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/widgets/expandable_list.dart';

class MembersOfGroupWidget extends StatelessWidget {
  Group group;
  MembersOfGroupWidget({required this.group});
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: group.members.map((member) => Text(member.name)).toList());
  }
}
