import 'package:flutter/material.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/widgets/network_buttons/vi_network_icon_button.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/admission_to_group_controller.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/group_settings_group.dart';

class AdmitToJoinGroupWidget extends StatelessWidget {
  final Group group;
  late final AdminssionToGroupController _admissionToGroupController;

  //Returns Stream of all user who are currently requesting to Join
  AdmitToJoinGroupWidget({required this.group}) {
    _admissionToGroupController = new AdminssionToGroupController(group: group);
  }
  @override
  Widget build(BuildContext context) {
    //Listener recognizes changes in group
    //When a group changes he notifies the cubit to update itself
    return group.requestedToJoin != null && group.requestedToJoin!.length > 0
        ? GroupSettingsGroup(
            highlight: true,
            padded: false,
            title: "Mitglieder Anfragen",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: group.requestedToJoin!.map(
                (UserReference user) {
                  return Container(
                    padding: EdgeInsets.only(left: 3),
                    child: ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(user.name),
                        trailing: Wrap(children: [
                          ViNetworkIconButton(
                            onPressed: () => _admissionToGroupController
                                .acceptUser(user: user),
                            icon: Icon(Icons.check),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          ViNetworkIconButton(
                            onPressed: () => _admissionToGroupController
                                .declineUser(user: user),
                            icon: Icon(Icons.close),
                            padding: EdgeInsets.only(left: 10),
                          ),
                        ])),
                  );
                },
              ).toList(),
            ),
          )
        : Container();
  }
}
