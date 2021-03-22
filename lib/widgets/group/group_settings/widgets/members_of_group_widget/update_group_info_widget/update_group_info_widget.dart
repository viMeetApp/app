import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/widgets/vi_dialog.dart';

class UpdateGroupInfoWidget extends StatelessWidget {
  final Group group;
  final descriptionController;
  UpdateGroupInfoWidget({required this.group})
      : descriptionController = new TextEditingController(text: group.about);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.group),
          subtitle: Text("Gruppenname"),
          onTap: () {
            ViDialog.showTextInputDialog(
              title: "Gruppenname",
              currentValue: group.name,
              context: context,
              keyboardType: TextInputType.number,
            ).then((value) {
              if (value != null) {
                group.name = value;
                BlocProvider.of<GroupSettingsCubit>(context)
                    .updateGroup(group: group, ctx: context);
              }
            });
          },
          title: Text(group.name!),
        ),
        ListTile(
          leading: Icon(Icons.subject),
          subtitle: Text("Beschreibung"),
          onTap: () {
            ViDialog.showTextInputDialogMultiline(
              title: "Beschreibung",
              currentValue: group.about,
              context: context,
              keyboardType: TextInputType.text,
            ).then((value) {
              if (value != null) {
                group.about = value;
                BlocProvider.of<GroupSettingsCubit>(context)
                    .updateGroup(group: group, ctx: context);
              }
            });
          },
          title: Text(group.about!),
        ),
      ],
    );
  }
}
