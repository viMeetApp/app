import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/find_new_group/find_new_group.dart';
import 'package:signup_app/groupList/group_list_view.dart';
import 'package:signup_app/postList/implementations/plainPostList.dart';
import 'package:signup_app/repositories/group_pagination.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class MessageFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meine Nachrichten", style: AppThemeData.textHeading2()),
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
