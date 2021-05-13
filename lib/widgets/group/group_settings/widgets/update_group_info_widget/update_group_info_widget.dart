import 'package:flutter/material.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/common.dart';

class UpdateGroupInfoWidget extends StatelessWidget {
  final Group group;
  final descriptionController;
  final GroupRepository _groupRepository = new GroupRepository();
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
                _groupRepository.updateGroup(group);
              }
            });
          },
          title: Text(group.name),
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
                _groupRepository.updateGroup(group);
              }
            });
          },
          title: Text(group.about),
        ),
      ],
    );
  }
}
