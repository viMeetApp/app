import 'package:flutter/material.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:signup_app/widgets/post_list/view/post_list_widget.dart';

class MessageFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meine Nachrichten", style: AppThemeData.textHeading2()),
        leading: null,
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
          child: PostList(
            //ToDo fix this with User but therefore usere constructor must work
            user: User(
                name: 'egal', id: fire.FirebaseAuth.instance.currentUser!.uid),
          ),
        ),
      ),
    );
  }
}
