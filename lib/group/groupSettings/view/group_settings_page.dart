import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/group/groupSettings/view/group_settings_main_view.dart';
import 'package:signup_app/util/data_models.dart';

class GroupSettingsPage extends StatelessWidget {
  final Group group;
  GroupSettingsPage({@required this.group});
  static Route route({@required Group group}) {
    return MaterialPageRoute<void>(
        builder: (_) => GroupSettingsPage(
              group: group,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupSeetingsCubit>(
      create: (_) => GroupSeetingsCubit(group: group),
      child: BlocBuilder<GroupSeetingsCubit, GroupSettingsState>(
        builder: (context, state) {
          if (state is AdminSettings) {
            return GroupSettingsMainView(
              state: state,
            );
          } else if (state is MemberSettings) {
            return GroupSettingsMainView(
              state: state,
            );
          } else
            //Make this a bit nice
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
