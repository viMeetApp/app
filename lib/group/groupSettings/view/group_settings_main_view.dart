import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/cubit/group_cubit.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/group/groupSettings/widget/requestedToJoinWidget.dart';
import 'package:signup_app/group/groupSettings/widget/updateSettingsWidget.dart';
import 'package:signup_app/group/groupSettings/widget/userListWidget.dart';
import 'package:signup_app/login/login.dart';
import 'package:signup_app/post_detailed/cubit/subscription_cubit.dart';
import 'package:signup_app/util/presets.dart';

class GroupSettingsMainView extends StatelessWidget {
  final GroupMemberSettings state;
  GroupSettingsMainView({@required this.state});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppThemeData.colorControls),
        title: Text(
          "Einstellungen",
          style: AppThemeData.textHeading2(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: AppThemeData.colorPlaceholder,
                      backgroundImage:
                          AssetImage("assets/img/logo_light_text_trans.png"),
                      maxRadius: 50,
                      minRadius: 50,
                    ),
                  ),
                ),
              ]),
            ),
            if (state is AdminSettings)
              UpdateSettingsWidget(
                group: state.group,
              ),
            if (state is AdminSettings &&
                state.group.requestedToJoin.length != 0)
              RequestedToJoinWidget(
                group: state.group,
              ),
            UserListWidget(group: state.group),
            FlatButton(
              child: Text('Gruppe verlassen'),
              onPressed: () {
                var oldContext = context;
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Gruppe verlassen'),
                          actions: [
                            FlatButton(
                              child: Text('abbrechen'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Gruppe verlassen'),
                              onPressed: () {
                                BlocProvider.of<GroupSeetingsCubit>(oldContext)
                                    .unsubscribeFromGroup()
                                    .then((_) {
                                  int count = 0;
                                  Navigator.popUntil(context, (route) {
                                    return count++ == 3;
                                  });
                                });
                              },
                            )
                          ],
                        ));
              },
            )
          ],
        ),
      ),
    );
  }
}
