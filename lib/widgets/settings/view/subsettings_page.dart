import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:signup_app/util/presets.dart';

class SubSettingsPage extends StatelessWidget {
  String? title = "Einstellungen";
  Widget? child;

  static Route route({required String title, required Widget child}) {
    return MaterialPageRoute<void>(
        builder: (_) => SubSettingsPage(title: title, child: child));
  }

  SubSettingsPage({this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppThemeData.colorControls),
          backgroundColor: Colors.transparent,
          title: Text(
            title!,
            style: TextStyle(color: AppThemeData.colorTextRegular),
          ),
        ),
        body: child);
  }
}
