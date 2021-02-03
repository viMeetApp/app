import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:signup_app/widgets/post_list/view/post_list_widget.dart';
import 'package:signup_app/junk/plainPostList.dart';

class MessageFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meine Nachrichten", style: AppThemeData.textHeading2()),
        leading: null,
        /*IconButton(
            icon: Icon(
              Icons.favorite,
              //color: AppThemeData.colorTextInverted,
            ),
            onPressed: () => {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("TODO: Show favorites")))
                }),*/
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
                name: 'egal', id: fire.FirebaseAuth.instance.currentUser.uid),
          ),
        ),
      ),
    );
  }
}
