import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/presets/presets.dart';

class TagsDialog extends StatelessWidget {
  List<String> tags;
  String postID;

  TagsDialog(this.postID, this.tags);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          color: AppThemeData.colorBase,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.all(AppThemeData.varPaddingCard * 3),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Wrap(
                spacing: 10,
                //runSpacing: 10,
                children: new List.generate(
                    tags.length,
                    (index) => Chip(
                          label: Text(tags[index]),
                        ))),
          )),
    );
  }
}
