import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signup_app/util/presets.dart';

class SuccessPage extends StatelessWidget {
  final String? message;
  SuccessPage({this.message});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'success',
      child: Scaffold(
        backgroundColor: AppThemeData.colorAccent,
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.check,
            color: AppThemeData.colorCard,
            size: 100,
          ),
          Text(message ?? "",
              style: TextStyle(
                  color: AppThemeData.colorCard,
                  fontWeight: FontWeight.bold,
                  fontSize: 28)),
          /*Text("Dein Bericht wurde übermittelt",
              style: AppThemeData.textHeading4(color: AppThemeData.colorCard))*/
        ])),
      ),
    );
  }
}