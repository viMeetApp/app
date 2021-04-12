import 'package:flutter/material.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/admission_to_group_controller.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/group_settings_group.dart';

class AdmitToJoinGroupWidget extends StatelessWidget {
  final Group group;
  late final AdminssionToGroupController _adminssionToGroupController;

  //Returns Stream of all user who are currently requesting to Join
  AdmitToJoinGroupWidget({required this.group}) {
    _adminssionToGroupController =
        new AdminssionToGroupController(group: group);
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
                          IconButton(
                            icon: Icon(Icons.check),
                            padding: EdgeInsets.only(left: 10),
                            onPressed: () {
                              _adminssionToGroupController.acceptUser(
                                  user: user);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            padding: EdgeInsets.only(left: 10),
                            onPressed: () {
                              _adminssionToGroupController.declineUser(
                                  user: user);
                            },
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
