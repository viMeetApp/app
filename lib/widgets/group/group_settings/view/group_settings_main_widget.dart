import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/view/admit_to_join_group_widget.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/group_settings_group.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/members_of_group_widget.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/update_group_info_widget/update_group_info_widget.dart';

class GroupSettingsMainWidget extends StatelessWidget {
  final Group? group;
  GroupSettingsMainWidget({required this.group});

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
        elevation: 0,
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
                      backgroundImage: AssetImage(
                          "assets/img/brand/logo_light_text_trans.png"),
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
                      ? GroupSettingsGroup(
                          title: "Informationen",
                          child: UpdateGroupInfoWidget(
                            group: group!,
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
            GroupSettingsGroup(
                title: group!.members.length.toString() + " Mitglieder",
                child: MembersOfGroupWidget(group: group!),
                padded: false),
          ],
        ),
      ),
    );
  }
}
