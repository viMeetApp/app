import 'package:flutter/material.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/post_list/implementations/filterable/post_list_filterable.dart';

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
          child: PostListFilterableWidget(),
        ),
      ),
    );
  }
}
