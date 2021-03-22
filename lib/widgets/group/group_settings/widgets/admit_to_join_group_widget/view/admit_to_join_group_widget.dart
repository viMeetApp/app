import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/cubit/admit_to_join_group_widget_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/group_settings_group.dart';

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
        child: Text("TODO: reenable"));
    /*BlocBuilder<AdmitToJoinGroupWidgetCubit, List<User>>(
          cubit: cubit,
          builder: (context, users) {
            return (users.length == 0)
                ? Container()
                : GroupSettingsGroup(
                    highlight: true,
                    padded: false,
                    title: "Mitglieder Anfragen",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: users.map(
                        (user) {
                          return Container(
                            padding: EdgeInsets.only(left: 3),
                            child: ListTile(
                                leading: Icon(Icons.account_circle),
                                title: Text(user.name),
                                trailing: Wrap(children: [
                                  IconButton(
                                    icon: Icon(Icons.check),
                                    padding: EdgeInsets.only(left: 10),
                                    onPressed: () {
                                      BlocProvider.of<GroupSettingsCubit>(
                                              context)
                                          .accepRequest(user: user);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    padding: EdgeInsets.only(left: 10),
                                    onPressed: () {
                                      BlocProvider.of<GroupSettingsCubit>(
                                              context)
                                          .declineRequest(user: user);
                                    },
                                  ),
                                ])),
                          );
                        },
                      ).toList(),
                    ));
          },
        ));*/
  }
}
