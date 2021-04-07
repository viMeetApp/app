import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart' as models;
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/widgets/group/group_settings/cubit/group_settings_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/widgets/member_tile.dart';

///This renders the expandable List of users
///It is necessary to be stateful
class ExpandableList extends StatefulWidget {
  final List<models.User> members;
  ExpandableList({required this.members});
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool isExpanded = false;
  final int usersNotExpanded =
      7; //Limit of users to display in not expanded format

  List<Widget> createListTiles(length, List<models.User> users, isAdmin) {
    List<Widget> widgets = [];
    //Iterarte over all users (only those to be displayed)
    //For every user append a user Tile to widgets
    for (int i = 0; i < length; ++i) {
      widgets.add(
        Padding(
            padding: EdgeInsets.only(left: 3),
            child: MemberTile(
              user: users[i],
              userHasAdminRights: isAdmin,
            )),
      );
    }
    return widgets;
  }

  Widget showExpandButton() {
    return FlatButton.icon(
      textColor: Colors.black,
      onPressed: () {
        isExpanded = true;
        setState(() {});
      },
      icon: Icon(Icons.expand_more),
      label: Expanded(
          child: Text(
        "Zeige ${widget.members.length - usersNotExpanded} weitere",
        style: AppThemeData.textFormField(color: null),
      )),
    );
  }

  bool shouldShowExpandedButton(listLength) {
    return !isExpanded && widget.members.length != listLength;
  }

  @override
  Widget build(BuildContext context) {
    final bool currentUserIsAdminForThisGroup =
        BlocProvider.of<GroupSettingsCubit>(context)
            .state
            .group
            .isAdmin(FirebaseAuth.instance.currentUser!.uid);

    //Length of list currently displayed
    int listLength = isExpanded
        ? widget.members.length
        : min(usersNotExpanded, widget.members.length);

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...createListTiles(
              listLength, widget.members, currentUserIsAdminForThisGroup),
          if (shouldShowExpandedButton(listLength)) showExpandButton()
        ],
      ),
    );
  }
}
