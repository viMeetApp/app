import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class InfoSection extends StatelessWidget {
  final Post post;

  InfoSection(this.post);

  IconData iconFromDetailsID(String id) {
    IconData iconData = Icons.error;
    if (id == "kosten") iconData = Icons.euro_symbol;
    if (id == "treffpunkt") iconData = Icons.location_on;
    if (id == "about") iconData = Icons.subject;

    return iconData;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(post.about +
              "On some terminals, these characters are not available at all, and the complexity of the escape sequences discouraged their use, so often only ASCII characters that approximate box-drawing characters are used, such as")),
      Column(
          children: new List.generate(
              post.details.length,
              (index) => Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15, left: 10, bottom: 8, top: 8),
                        child: Icon(
                          iconFromDetailsID(post.details[index].id),
                          color: AppThemeData.colorPlaceholder,
                        ),
                      ),
                      Expanded(
                          child: Text(
                        post.details[index].value,
                        style: AppThemeData.textHeading4(
                            color: AppThemeData.colorPlaceholder),
                      ))
                    ],
                  )))
    ]);
  }
}
