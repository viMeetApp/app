import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/cubit/group_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/view/group_settings_main_widget.dart';
import 'package:signup_app/util/models/data_models.dart';

class GroupSettingsPage extends StatelessWidget {
  final Group group;
  final GroupCubit groupCubit;
  GroupSettingsPage({required this.group, required this.groupCubit});
  static Route route({required Group group, required GroupCubit groupCubit}) {
    return MaterialPageRoute<void>(
        builder: (_) => GroupSettingsPage(
              group: group,
              groupCubit: groupCubit,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: groupCubit, child: GroupSettingsMainWidget(group: group));
  }
}
