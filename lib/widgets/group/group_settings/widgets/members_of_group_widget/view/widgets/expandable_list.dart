import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

///This renders the expandable List of users
///It is necessary to be stateful
class ExpandableList extends StatefulWidget {
  final List<User> members;
  ExpandableList({@required this.members});
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  bool isExpanded = false;
  final int usersNotExpanded =
      7; //Limit of users to display in not expanded format

  List<Widget> createListTiles(length, List<User> users) {
    List<Widget> widgets = [];
    //Iterarte over all users (only those to be displayed)
    //For every user append a user Tile to widgets
    for (int i = 0; i < length; ++i) {
      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(users[i].name),
          ),
        ),
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
    //Length of list currently displayed
    int listLength = isExpanded
        ? widget.members.length
        : min(usersNotExpanded, widget.members.length);

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...createListTiles(listLength, widget.members),
          if (shouldShowExpandedButton(listLength)) showExpandButton()
        ],
      ),
    );
  }
}
