import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/dialog_helper.dart';
import 'package:signup_app/util/presets.dart';

class UpdateSettingsWidget extends StatelessWidget {
  static ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
  final Group group;
  final descriptionController;
  UpdateSettingsWidget({@required this.group})
      : descriptionController = new TextEditingController(text: group.about);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.group),
          subtitle: Text("Gruppenname"),
          onTap: () {
            DialogHelper.showTextInputDialog(
              title: "Gruppenname",
              currentValue: group.name,
              context: context,
              keyboardType: TextInputType.number,
            ).then((value) {
              if (value != null) {
                group.name = value;
                BlocProvider.of<GroupSeetingsCubit>(context)
                    .updateGroup(group: group, ctx: context);
              }
            });
          },
          title: Text(group.name),
        ),
        ListTile(
          leading: Icon(Icons.subject),
          subtitle: Text("Beschreibung"),
          onTap: () {
            DialogHelper.showTextInputDialogMultiline(
              title: "Beschreibung",
              currentValue: group.about,
              context: context,
              keyboardType: TextInputType.text,
            ).then((value) {
              if (value != null) {
                group.about = value;
                BlocProvider.of<GroupSeetingsCubit>(context)
                    .updateGroup(group: group, ctx: context);
              }
            });
          },
          title: Text(group.about),
        ),
      ],
    );
  }
}
