import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/cubit/members_of_group_widget_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/widgets/expandable_list.dart';

class MembersOfGroupWidget extends StatelessWidget {
  final MembersOfGroupWidgetCubit cubit;
  MembersOfGroupWidget({required Group group})
      : cubit = MembersOfGroupWidgetCubit(
          group: group,
        );

  @override
  Widget build(BuildContext context) {
    //When group changes update Stream via cubit
    return BlocListener<GroupSettingsCubit, GroupSettingsState>(
        listener: (context, state) {
          cubit.updateStreamSubscription(state.group);
        },
        child: Text("TODO: reenable"));
    /*BlocBuilder<MembersOfGroupWidgetCubit, List<User>>(
        cubit: cubit,
        builder: (context, users) {
          return ExpandableList(members: users);
        },
      ),
    );*/
  }
}
