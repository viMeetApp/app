import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class RequestedToJoinWidget extends StatelessWidget {
  final Group group;
  final StreamController<List<User>> streamController =
      StreamController<List<User>>();
  //Returns Stream of all user who are currently requesting to Join
  RequestedToJoinWidget({@required this.group}) {
    streamController.addStream(FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereIn: group.requestedToJoin)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => User.fromDatabaseSnapshot(doc)).toList()));
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupSeetingsCubit, GroupSettingsState>(
      listener: (context, state) async {
        log("Listener");
        await streamController.close();
        group.users = (state as GroupMemberSettings).group.users;
        streamController.addStream(FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: group.requestedToJoin)
            .snapshots()
            .map((list) => list.docs
                .map((doc) => User.fromDatabaseSnapshot(doc))
                .toList()));
      },
      child: StreamBuilder(
        stream: streamController.stream,
        builder: (context, AsyncSnapshot<List<User>> userSnap) {
          //As Long as Stream is Empty don't render anything on Screen
          if (userSnap.hasError || !userSnap.hasData) {
            return Container();
          }
          //If Stream not Empty REnder List of akk willing to Join
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mitglieder Anfragen:",
                  style: AppThemeData.textHeading4(),
                ),
                Column(
                  children: userSnap.data.map(
                    (user) {
                      return RequestWidget(
                        user: user,
                      );
                    },
                  ).toList(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class RequestWidget extends StatelessWidget {
  final User user;
  RequestWidget({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(4),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(user.name)),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<GroupSeetingsCubit>(context)
                        .accepRequest(user: user);
                  },
                  icon: Icon(Icons.done),
                  color: Colors.green,
                ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<GroupSeetingsCubit>(context)
                          .declineRequest(user: user);
                    },
                    icon: Icon(Icons.clear),
                    color: Colors.red)
              ],
            ),
          ),
        ));
  }
}
