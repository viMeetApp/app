import 'package:flutter/material.dart';
import 'package:signup_app/repositories/group_pagination.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/group_list/view/group_list_widget.dart';

///Shows a List of all Groups which User is currently Not Part Of
class FindNewGroup extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => FindNewGroup());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Finde neue Gruppen", style: AppThemeData.textHeading2()),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppThemeData.colorCard,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: new InputDecoration(
                          hintText: "Suche",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GroupListWidget(
                groupStream: GroupPagination.getNewGroups(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
