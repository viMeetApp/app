import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/group/groupSettings/cubit/group_seetings_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class RequestedToJoinWidget extends StatelessWidget {
  final Group group;
  final Stream<List<User>> requestedToJoinStream;
  RequestedToJoinWidget({@required this.group})
      : requestedToJoinStream = FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: group.requestedToJoin)
            .snapshots()
            .map((list) =>
                list.docs.map((doc) => User.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 6),
          StreamBuilder(
            stream: requestedToJoinStream,
            builder: (context, AsyncSnapshot<List<User>> userSnap) {
              if (userSnap.hasError || !userSnap.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: userSnap.data.map(
                  (user) {
                    return RequestWidget(
                      user: user,
                    );
                  },
                ).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RequestWidget extends StatelessWidget {
  final User user;
  RequestWidget({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(AppThemeData.varCardRadius)),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(user.uid)),
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
    );
  }
}
