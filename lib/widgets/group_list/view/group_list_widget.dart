import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/group/view/group_page.dart';

class GroupListWidget extends StatelessWidget {
  final Stream<List<Group>> groupStream;
  GroupListWidget({required this.groupStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: groupStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              height: 0,
            );
          else {
            return ListView.builder(
                //ToDO Maybe only make scrollable if needed
                itemCount: (snapshot.data! as List).length,
                itemBuilder: (context, index) {
                  return ListElement(
                    group: (snapshot.data! as List)[index],
                  );
                });
          }
        });
  }
}

class ListElement extends StatelessWidget {
  final Group? group;
  ListElement({required this.group});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, GroupPage.route(group: group));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "group_icon" + group!.id!,
              child: CircleAvatar(
                backgroundColor: AppThemeData.colorPlaceholder,
                backgroundImage: AssetImage("assets/img/exampleImage2.jpg"),
                radius: 30,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Flexible(
              child: Text(group!.name!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
