import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class UserListWidget extends StatelessWidget {
  final Group group;
  final Stream<List<User>> userStream;
  UserListWidget({@required this.group})
      : userStream = FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: group.users)
            .snapshots()
            .map((list) =>
                list.docs.map((doc) => User.fromJson(doc.data())).toList());

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
        StreamBuilder(
          stream: userStream,
          builder: (context, AsyncSnapshot<List<User>> userSnap) {
            if (userSnap.hasError || !userSnap.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: userSnap.data.map(
                (user) {
                  return ListWidget(
                      user: user, isAdmin: group.admins.contains(user.uid));
                },
              ).toList(),
            );
          },
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class ListWidget extends StatelessWidget {
  final User user;
  final bool isAdmin;
  ListWidget({@required this.user, @required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(AppThemeData.varCardRadius),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(user.name), if (isAdmin) Text("Admin")],
      ),
    );
  }
}
