import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
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
        .map((list) =>
            list.docs.map((doc) => User.fromDatabaseSnapshot(doc)).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupSeetingsCubit, GroupSettingsState>(
      listener: (context, state) async {
        await streamController.close();
        group.users = (state as GroupMemberSettings).group.users;
        streamController.addStream(FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: group.users)
            .snapshots()
            .map((list) => list.docs
                .map((doc) => User.fromDatabaseSnapshot(doc))
                .toList()));
      },
      child: StreamBuilder(
        stream: streamController.stream,
        builder: (context, AsyncSnapshot<List<User>> userSnap) {
          //While no User Information loaded Show nothing
          if (userSnap.hasError || !userSnap.hasData) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mitglieder:",
                  style: AppThemeData.textHeading4(),
                ),
                ExpandableList(members: userSnap.data)
              ],
            ),
          );
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
    if (!isExpanded) {
      for (int i = 0; i < widget.shortendList.length; ++i) {
        widgets.add(ListTileWidget(
          user: widget.members[i],
        ));
        widgets.add(Divider(color: Colors.black));
      }
    } else {
      for (int i = 0; i < widget.members.length; ++i) {
        widgets.add(ListTileWidget(
          user: widget.members[i],
        ));
        widgets.add(Divider(
          color: Colors.black,
        ));
      }
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(AppThemeData.varCardRadius)),
      margin: const EdgeInsets.all(8),
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

class ListTileWidget extends StatelessWidget {
  final User user;
  ListTileWidget({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(user.name),
        ],
      ),
    );
  }
}
