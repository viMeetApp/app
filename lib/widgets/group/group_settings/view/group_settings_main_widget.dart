import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/view/admit_to_join_group_widget.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/members_of_group_widget.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/update_settings_widget.dart';

class GroupSettingsMainWidget extends StatelessWidget {
  final Group group;
  GroupSettingsMainWidget({@required this.group});

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
            //Widgtes are only rebuild when the Type os Settings State changes
            //During the same state it is a widgtes responsibility to update itself
            //not the resonsibility of the BlocBuilder
            BlocBuilder<GroupSettingsCubit, GroupSettingsState>(
                buildWhen: (curr, last) => curr.runtimeType != last.runtimeType,
                builder: (context, state) {
                  return state is AdminSettings
                      ? _settingsGroup(
                          title: "Informationen",
                          child: UpdateSettingsWidget(
                            group: group,
                          ),
                        )
                      : Container();
                }),
            BlocBuilder<GroupSettingsCubit, GroupSettingsState>(
                buildWhen: (curr, last) => curr.runtimeType != last.runtimeType,
                builder: (context, state) {
                  return state is AdminSettings
                      ? AdmitToJoinGroupWidget(
                          group: group,
                        )
                      : Container();
                }),
            BlocBuilder<GroupSettingsCubit, GroupSettingsState>(
                buildWhen: (curr, last) => curr.runtimeType != last.runtimeType,
                builder: (context, state) {
                  return _settingsGroup(
                      title: "Mitglieder",
                      child: MembersOfGroupWidget(group: group),
                      padded: false);
                }),
          ],
        ),
      ),
    );
  }
}
