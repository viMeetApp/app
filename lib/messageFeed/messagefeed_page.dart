import 'package:flutter/material.dart';
import 'package:signup_app/postList/implementations/plainPostList.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;

class MessageFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meine Nachrichten", style: AppThemeData.textHeading2()),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              //color: AppThemeData.colorTextInverted,
            ),
            onPressed: () => {},
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: PlainPostList(
            //ToDo fix this with User but therefore usere constructor must work
            user: User(
                name: 'egal', id: fire.FirebaseAuth.instance.currentUser.uid),
          ),
        ),
      ),
    );
  }
}
