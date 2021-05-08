import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:signup_app/util/models/data_models.dart' as models;
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/widgets/group/group_settings/widgets/members_of_group_widget/view/widgets/member_tile.dart';

///This renders the expandable List of users
///It is necessary to be stateful
class ExpandableList extends StatefulWidget {
  final List<models.GroupUserReference> members;
  ExpandableList({required this.members});
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool isExpanded = false;
  final int usersNotExpanded =
      7; //Limit of users to display in not expanded format

  List<Widget> createListTiles(
      length, List<models.GroupUserReference> users, bool currentUserIsAdmin) {
    List<Widget> widgets = [];
    //Iterarte over all users (only those to be displayed)
    //For every user append a user Tile to widgets
    for (int i = 0; i < length; ++i) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: MemberTile(
            user: users[i],
            currentUserIsAdmin: currentUserIsAdmin,
          ),
        ),
      );
    }
    return widgets;
  }

  Widget showExpandButton() {
    return TextButton.icon(
      onPressed: () {
        isExpanded = true;
        setState(() {});
      },
      icon: Icon(Icons.expand_more),
      label: Expanded(
        child: Text(
          "Zeige ${widget.members.length - usersNotExpanded} weitere",
          style: AppThemeData.textFormField(color: null),
        ),
      ),
    );
  }

  bool shouldShowExpandedButton(listLength) {
    return !isExpanded && widget.members.length != listLength;
  }

  bool currentUserIsAdmin(List<models.GroupUserReference> users) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final models.GroupUserReference? user = users.firstWhereOrNull(
        (models.GroupUserReference user) => user.id == userId);

    if (user != null) return user.isAdmin;
    throw ('User who is not member of Group has accessed Settings Page');
  }

  @override
  Widget build(BuildContext context) {
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
              listLength, widget.members, currentUserIsAdmin(widget.members)),
          if (shouldShowExpandedButton(listLength)) showExpandButton()
        ],
      ),
    );
  }
}
