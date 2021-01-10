import 'package:flutter/material.dart';
import 'package:signup_app/repositories/group_pagination.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/find_new_group/find_new_group.dart';
import 'package:signup_app/widgets/group_list/view/group_list_widget.dart';

class GroupFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ToDo Sytle appropriately
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Finde neue Gruppen',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.push(context, FindNewGroup.route());
        },
        icon: Icon(
          Icons.search,
          color: AppThemeData.colorCard,
        ),
        backgroundColor: AppThemeData.colorPrimaryLight,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("Meine Gruppen", style: AppThemeData.textHeading2()),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () => {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("TODO: Neue Gruppe erstellen")))
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: GroupListWidget(
            groupStream: GroupPagination.getSubscribedGroups(),
          ),
        ),
      ),
    );
  }
}
