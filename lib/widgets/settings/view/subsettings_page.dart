import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/common.dart';

class SubSettingsPage extends StatelessWidget {
  final String title;
  final Widget child;

  static Route route({required String title, required Widget child}) {
    return MaterialPageRoute<void>(
        builder: (_) => SubSettingsPage(title: title, child: child));
  }

  SubSettingsPage({this.title = "Einstellungen", required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppThemeData.colorControls),
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: TextStyle(color: AppThemeData.colorTextRegular),
          ),
        ),
        body: child);
  }
}
