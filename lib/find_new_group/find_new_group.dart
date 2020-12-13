import 'package:flutter/material.dart';
import 'package:signup_app/groupList/group_list_view.dart';
import 'package:signup_app/repositories/group_pagination.dart';
import 'package:signup_app/util/presets.dart';

///Shows a List of all Groups which User is currently Not Part Of
class FindNewGroup extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => FindNewGroup());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finde neue Gruppen", style: AppThemeData.textHeading2()),
      ),
      body: SafeArea(
        child: Center(
          child: GroupListView(
            groupStream: GroupPagination.getNewGroups(),
          ),
        ),
      ),
    );
  }
}
