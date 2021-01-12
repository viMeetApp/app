import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class UserListWidget extends StatelessWidget {
  final Group group;
  final StreamController<List<User>> streamController =
      StreamController<List<User>>();
  //final Stream<List<User>> userStream;
  UserListWidget({@required this.group}) //Stream of all Members of the Group
  {
    streamController.addStream(FirebaseFirestore.instance
        .collection('users')
        .where('__name__', whereIn: group.users)
        .snapshots()
        .map((list) => list.docs.map((doc) => User.fromDoc(doc)).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupSettingsCubit, GroupSettingsState>(
      listener: (context, state) async {
        await streamController.close();
        group.users = (state as GroupMemberSettings).group.users;
        streamController.addStream(FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: group.users)
            .snapshots()
            .map((list) => list.docs.map((doc) => User.fromDoc(doc)).toList()));
      },
      child: StreamBuilder(
        stream: streamController.stream,
        builder: (context, AsyncSnapshot<List<User>> userSnap) {
          //While no User Information loaded Show nothing
          if (userSnap.hasError || !userSnap.hasData) {
            return Container();
          }
          return ExpandableList(members: userSnap.data);
        },
      ),
    );
  }
}

class ExpandableList extends StatefulWidget {
  final List<User> members;
  List<User> shortendList;
  ExpandableList({@required this.members}) {
    shortendList = members.length >= 7 ? members.sublist(0, 7) : members;
  }

  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    //Create List to Shown with Dividers
    int listLength =
        isExpanded ? widget.shortendList.length : widget.members.length;
    for (int i = 0; i < listLength; ++i) {
      widgets.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(widget.members[i].name),
          )));
      if (i < (widget.shortendList.length - 1)) {
        widgets.add(Divider(
          color: Colors.grey[350],
          height: 1,
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widgets,
          if (!isExpanded &&
              widget.shortendList.length != widget.members.length)
            FlatButton.icon(
              textColor: Colors.black,
              onPressed: () {
                isExpanded = true;
                setState(() {});
              },
              icon: Icon(Icons.expand_more),
              label: Expanded(
                  child: Text(
                "Zeige ${widget.members.length - widget.shortendList.length} weitere",
                style: AppThemeData.textFormField(color: null),
              )),
            )
        ],
      ),
    );
  }
}

/*class ListTileWidget extends StatelessWidget {
  final User user;
  ListTileWidget({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(user.name),
        ],
      ),
    );
  }
}*/
