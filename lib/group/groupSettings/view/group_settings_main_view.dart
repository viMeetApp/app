import 'package:flutter/material.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/group/groupSettings/widget/requestedToJoinWidget.dart';
import 'package:signup_app/group/groupSettings/widget/updateSettingsWidget.dart';
import 'package:signup_app/group/groupSettings/widget/userListWidget.dart';
import 'package:signup_app/util/presets.dart';

class GroupSettingsMainView extends StatelessWidget {
  final GroupMemberSettings state;
  GroupSettingsMainView({@required this.state});

  Widget _settingsGroup({String title, Widget child, bool padded = true}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      padding: EdgeInsets.all(padded ? 20 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: padded ? 0 : 20,
                left: padded ? 0 : 20,
                right: padded ? 0 : 20,
                bottom: 10),
            child: Text(
              title,
              style: AppThemeData.textHeading4(),
            ),
          ),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppThemeData.colorControls),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Gruppen Einstellungen",
          style: AppThemeData.textHeading2(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: AppThemeData.varPaddingEdges,
            right: AppThemeData.varPaddingEdges),
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
              _settingsGroup(
                title: "Informationen",
                child: UpdateSettingsWidget(
                  group: state.group,
                ),
              ),
            if (state is AdminSettings &&
                state.group.requestedToJoin.length != 0)
              RequestedToJoinWidget(
                group: state.group,
              ),
            _settingsGroup(
                title: "Mitglieder",
                child: UserListWidget(group: state.group),
                padded: false),
          ],
        ),
      ),
    );
  }
}
