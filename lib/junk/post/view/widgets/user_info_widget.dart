import 'package:flutter/material.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/presets/presets.dart';

class UserInfoWidget extends StatelessWidget {
  final Post? post;
  UserInfoWidget({required this.post});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 7),
      child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              padding: EdgeInsets.all(0),
              visualDensity: VisualDensity.compact,
              textColor: AppThemeData.colorControls,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(Icons.person),
                  ),
                  Text(
                    post!.author!.name!,
                    style: AppThemeData.textNormal(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onPressed: () => {},
            ),
            (post!.group != null)
                ? FlatButton(
                    padding: EdgeInsets.all(0),
                    visualDensity: VisualDensity.compact,
                    textColor: AppThemeData.colorControls,
                    child: Row(
                      children: [
                        Container(
                          //padding: const EdgeInsets.only(right: 5),
                          child: Text("   in "),
                        ),
                        Text(
                          post!.group!.name!,
                          style: AppThemeData.textNormal(
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () => {},
                  )
                : Text(""),
          ]),
    );
  }
}
