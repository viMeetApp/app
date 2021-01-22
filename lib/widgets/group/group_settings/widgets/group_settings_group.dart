import 'package:flutter/material.dart';
import 'package:signup_app/util/presets.dart';

class GroupSettingsGroup extends StatelessWidget {
  String title;
  Widget child;
  bool padded;
  bool highlight;

  GroupSettingsGroup(
      {this.title = "Group",
      this.child,
      this.padded = true,
      this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: highlight ? AppThemeData.swatchAccent[100] : Colors.white,
          border: Border.all(
              width: 3,
              color: highlight
                  ? AppThemeData.swatchAccent[300]
                  : Colors.transparent)),
      padding: EdgeInsets.all(padded ? 20 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: padded ? 0 : 20,
                left: padded ? 0 : 20,
                right: padded ? 0 : 20,
                bottom: 10),
            child: Text(
              title,
              style: AppThemeData.textHeading4(),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
