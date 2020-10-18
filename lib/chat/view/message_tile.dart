import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/DataModels.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  
  MessageTile({@required this.message});
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    if(message.author.uid==FirebaseAuth.instance.currentUser.uid){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(minWidth: size.width*0.3, maxWidth: size.width*0.7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.grey[300]),
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      message.author.name,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold), //!What Color
                    ),
                  ),
                  Text(
                    message.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1000, //Change Later
                  ),
                ],
              ),
            ),
          ],
        ),
      );

    }
    else{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.grey[300]),
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      message.content,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold), //!What Color
                    ),
                  ),
                  Text(
                    message.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1000, //Change Later
                  ),
                ],
              ),
            ),
          ],
        ),
      );

    }
  }
}