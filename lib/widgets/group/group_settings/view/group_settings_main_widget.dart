import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/cubit/group_cubit.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/admit_to_join_group_widget/view/admit_to_join_group_widget.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/group_settings_group.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/members_of_group_widget.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/update_group_info_widget/update_group_info_widget.dart';
import 'package:signup_app/widgets/shared/network_images/update_image/implementations/update_group_image.dart';

class GroupSettingsMainWidget extends StatelessWidget {
  GroupSettingsMainWidget();

  @override
  Widget build(BuildContext context) {
    final GroupCubit _groupCubit = BlocProvider.of<GroupCubit>(context);
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
      body:
          // When somehow user is not Member anymore but still in Settings Page -> pop back to Group Page
          BlocListener<GroupCubit, GroupState>(
        listenWhen: (_, curr) => curr is NotGroupMember,
        listener: (context, state) => Navigator.of(context).pop(),
        child: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            return Padding(
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
                          child: UpdateGroupImage(
                            group: state.group,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  if (state is GroupAdmin) ...[
                    GroupSettingsGroup(
                      title: "Informationen",
                      child: UpdateGroupInfoWidget(
                        group: _groupCubit.state.group,
                      ),
                    ),
                    AdmitToJoinGroupWidget(
                      group: _groupCubit.state.group,
                    ),
                  ],
                  GroupSettingsGroup(
                      title: _groupCubit.state.group.members.length.toString() +
                          " Mitglieder",
                      child:
                          MembersOfGroupWidget(group: _groupCubit.state.group),
                      padded: false),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
