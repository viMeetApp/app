import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  MessageTile({@required this.message});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (message.author.uid == FirebaseAuth.instance.currentUser.uid) {
      return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                  minWidth: size.width * 0.3, maxWidth: size.width * 0.7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: AppThemeData.varChatBubbleRadius,
                    topRight: AppThemeData.varChatBubbleRadius,
                    bottomLeft: AppThemeData.varChatBubbleRadius),
                color: AppThemeData.swatchPrimary[50],
              ),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      message.author.name,
                      style: TextStyle(
                          color: AppThemeData.colorTextRegular,
                          fontWeight: FontWeight.bold),
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
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: AppThemeData.varChatBubbleRadius,
                      topRight: AppThemeData.varChatBubbleRadius,
                      bottomRight: AppThemeData.varChatBubbleRadius),
                  color: AppThemeData.colorCard),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      message.content,
                      style: TextStyle(
                          color: AppThemeData.colorControls,
                          fontWeight: FontWeight.bold),
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
