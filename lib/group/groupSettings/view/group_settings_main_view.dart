import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/group/groupSettings/widget/userListWidget.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class GroupSettingsMainView extends StatelessWidget {
  final GroupSettingsState state;
  GroupSettingsMainView({@required this.state});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppThemeData.colorControls),
        title: Text(
          state.group.name,
          style: TextStyle(color: AppThemeData.colorTextRegular),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                (state as AdminSettings).requestedToJoin.length != 0)
              RequestedToJoinWidget(
                  usersRequestingToJoin:
                      (state as AdminSettings).requestedToJoin),
            UserListWidget(group: state.group)
          ],
        ),
      ),
    );
  }
}

class UpdateSettingsWidget extends StatelessWidget {
  final Group group;
  final descriptionController;
  UpdateSettingsWidget({@required this.group})
      : descriptionController = new TextEditingController(text: group.about);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gruppeneinstellungen: ",
          style: AppThemeData.textHeading4,
        ),
        SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            minLines: 3,
            maxLines: 5,
            controller: descriptionController,
            decoration: Presets.getTextFieldDecorationLabelStyle(
                labelText: "Gruppenbeschreibung"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Updating Group")));
                BlocProvider.of<GroupSeetingsCubit>(context)
                    .updateGroupSettings(about: descriptionController.text)
                    .then((val) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Update Erfolgreich")));
                }).catchError((err) {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("Netzwerkfehler")));
                });
              },
              child: Text("Update"),
              color: Colors.green,
            )
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class RequestedToJoinWidget extends StatelessWidget {
  List<User> usersRequestingToJoin;
  RequestedToJoinWidget({@required this.usersRequestingToJoin});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mitglieder:",
          style: AppThemeData.textHeading4,
        ),
        SizedBox(height: 6),
        ...usersRequestingToJoin.map((user) {
          Widget temp = Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(AppThemeData.varCardRadius)),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(user.uid)),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<GroupSeetingsCubit>(context)
                        .accepRequest(user: user);
                  },
                  icon: Icon(Icons.done),
                  color: Colors.green,
                ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<GroupSeetingsCubit>(context)
                          .declineRequest(user: user);
                    },
                    icon: Icon(Icons.clear),
                    color: Colors.red)
              ],
            ),
          );
          return temp;
        }),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
