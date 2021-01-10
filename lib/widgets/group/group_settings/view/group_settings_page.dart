import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/view/group_settings_main_widget.dart';
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
          return GroupSettingsMainWidget(
            state: state,
          );
        },
      ),
    );
  }
}
