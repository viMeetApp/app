import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/cubit/admit_to_join_group_widget_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/view/widgets/request_widget.dart';

class AdmitToJoinGroupWidget extends StatelessWidget {
  final AdmitToJoinGroupWidgetCubit cubit;
  //Returns Stream of all user who are currently requesting to Join
  AdmitToJoinGroupWidget({@required group})
      : cubit = AdmitToJoinGroupWidgetCubit(group: group);
  @override
  Widget build(BuildContext context) {
    //Listener recognizes changes in group
    //When a group changes he notifies the cubit to update itself
    return BlocListener<GroupSettingsCubit, GroupSettingsState>(
        listener: (context, state) {
          cubit.updateStreamSubscription(state.group);
        },
        child: BlocBuilder<AdmitToJoinGroupWidgetCubit, List<User>>(
          cubit: cubit,
          builder: (context, users) {
            if (users.length == 0) return Container();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mitglieder Anfragen:",
                    style: AppThemeData.textHeading4(),
                  ),
                  Column(
                    children: users.map(
                      (user) {
                        return RequestWidget(
                          user: user,
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            );
          },
        ));
  }
}
