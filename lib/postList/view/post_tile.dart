import 'package:flutter/material.dart';
import 'package:signup_app/post_detailed/view/post_detailed_page.dart';
import 'package:signup_app/util/DataModels.dart';

class PostTile extends StatelessWidget {

  Post post;

  PostTile({@required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 120,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Colors.grey[500],//!Color
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Text(post.title),
          Text(post.about),
          if(post is Event) Text("Is Event") else Text("Is Buddy"),
        ],)

      ),
      onTap:(){
        Navigator.push(context, PostDetailedPage.route(post));
      }
    );
  }
}