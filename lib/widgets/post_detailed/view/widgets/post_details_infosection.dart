import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/post_detailed/view/post_detailed_page.dart';

class InfoSection extends StatelessWidget {
  final Post? post;

  InfoSection(this.post) {
    if (post is Event) {
      String formattedDate = ((post as Event).eventDate != null)
          ? DateFormat('dd.MM.yyyy').format(
              DateTime.fromMillisecondsSinceEpoch((post as Event).eventDate!))
          : "Datum unbekannt";

      // this is a hack to get the date field to the beginning of the list without changing the order of the other elements
      post!.details = post!.details!.reversed.toList();
      post!.details!.add(PostDetail(id: "date", value: formattedDate));
      post!.details = post!.details!.reversed.toList();
    }
  }

  IconData iconFromDetailsID(String? id) {
    IconData iconData = Icons.error;
    if (id == "kosten") iconData = Icons.euro_symbol;
    if (id == "date") iconData = Icons.event;
    if (id == "treffpunkt") iconData = Icons.location_on;
    if (id == "about") iconData = Icons.subject;

    return iconData;
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 300,
      child: ListView(shrinkWrap: true, children: [
        PostDetailedPage.getUserInfo(post!),
        Padding(
          padding: EdgeInsets.only(bottom: 13, top: 7),
          child: Text(
            post!.about!,
            textAlign: TextAlign.justify,
          ),
        ),
        /*Container(
          padding: EdgeInsets.only(bottom: 10),
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: new List.generate(
                post.tags.length,
                (index) => Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Chip(
                        backgroundColor: AppThemeData.swatchPrimary[50],
                        label: Text("#" + post.tags[index]),
                      ),
                    )),
          ),
        ),*/
        Column(
            children: new List.generate(
                post!.details!.length,
                (index) => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, bottom: 8, top: 8),
                          child: Icon(
                            iconFromDetailsID(post!.details![index]!.id),
                            color: AppThemeData.colorPlaceholder,
                          ),
                        ),
                        Expanded(
                            child: Text(
                          post!.details![index]!.value!,
                          style: AppThemeData.textHeading4(
                              color: AppThemeData.colorPlaceholder),
                        ))
                      ],
                    )))
      ]),
    );
  }
}
