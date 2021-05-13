import 'package:flutter/material.dart';
import 'package:signup_app/repositories/group_interactions.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/group_settings_group.dart';

class AdmitToJoinGroupWidget extends StatelessWidget {
  final Group group;
  late final GroupInteractions _groupInteractions;

  //Returns Stream of all user who are currently requesting to Join
  AdmitToJoinGroupWidget({required this.group}) {
    _groupInteractions = new GroupInteractions(group: group);
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
                            onPressed: () =>
                                _groupInteractions.acceptUser(user: user),
                            icon: Icon(Icons.check),
                          ),
                          ViNetworkIconButton(
                            onPressed: () =>
                                _groupInteractions.declineUser(user: user),
                            icon: Icon(Icons.close),
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
