import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/dialog_helper.dart';
import 'package:signup_app/util/presets.dart';

class UpdateSettingsWidget extends StatelessWidget {
  final Group group;
  final descriptionController;
  UpdateSettingsWidget({@required this.group})
      : descriptionController = new TextEditingController(text: group.about);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Einstellungen (das Design noch besser):",
            style: AppThemeData.textHeading4(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            //ToDo Decoration
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
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
                  ;
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    group.name,
                    style: AppThemeData.textFormField(color: null),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            //ToDo Decoration
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () {
                  DialogHelper.showTextInputDialogMultiline(
                    title: "Gruppenbeschreibung",
                    currentValue: group.about,
                    context: context,
                    keyboardType: TextInputType.number,
                  ).then((value) {
                    if (value != null) {
                      group.about = value;
                      BlocProvider.of<GroupSeetingsCubit>(context)
                          .updateGroup(group: group, ctx: context);
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    group.about,
                    style: AppThemeData.textFormField(color: null),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
