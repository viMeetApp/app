import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/view/group_settings_main_widget.dart';
import 'package:signup_app/util/models/data_models.dart';

class GroupSettingsPage extends StatelessWidget {
  final Group group;
  GroupSettingsPage({required this.group});
  static Route route({required Group group}) {
    return MaterialPageRoute<void>(
        builder: (_) => GroupSettingsPage(
              group: group,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupSettingsCubit>(
        create: (_) => GroupSettingsCubit(group: group),
        child: GroupSettingsMainWidget(group: group));
  }
}
