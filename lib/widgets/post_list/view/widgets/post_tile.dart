import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signup_app/widgets/post/view/post_page.dart';
import 'package:signup_app/widgets/post_detailed/view/post_detailed_page.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/report/view/report_dialog.dart';

class PostTile extends StatelessWidget {
  final Post? post;
  final bool highlight;

  PostTile({required this.post, this.highlight = false});

  Widget getEventDateText(Event event) {
    if (event.eventDate != null) {
      String formattedDate = DateFormat('dd.MM.yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(event.eventDate!));
      return Row(children: [
        Icon(
          Icons.event,
          color: AppThemeData.colorControls,
          size: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            formattedDate,
            style: TextStyle(
                color: AppThemeData.colorControls,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        )
      ]);
    }
    return Text(
      "Datum unbekannt",
      style: TextStyle(fontStyle: FontStyle.italic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            //height: 120,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 3,
                    color: (post!.group != null && highlight)
                        ? AppThemeData.swatchAccent[300]!
                        : Colors.transparent),
                color: (post!.group != null && highlight)
                    ? AppThemeData.swatchAccent[100]
                    : AppThemeData.colorCard,
                //AppThemeData.colorCard,
                borderRadius: BorderRadius.all(AppThemeData.varCardRadius)),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(children: [
                        Icon(
                          Icons.person,
                          size: 20,
                          color: AppThemeData.colorTextRegularLight,
                        ),
                        Container(
                            child: Text(
                              this.post!.author!.name!,
                              style: TextStyle(
                                  color: AppThemeData.colorTextRegularLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            padding: EdgeInsets.only(left: 5)),
                        if (this.post!.group != null)
                          Row(children: [
                            Text(
                              "  in  ",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              this.post!.group!.name!,
                              style: TextStyle(
                                  color: AppThemeData.colorTextRegularLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            )
                          ])
                      ]),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: AppThemeData.colorControlsDisabled,
                            ),
                            padding: const EdgeInsets.only(left: 10),
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                                  new PopupMenuItem<String>(
                                      child: const Text('teilen'),
                                      value: 'share'),
                                  new PopupMenuItem<String>(
                                      child: const Text('melden'),
                                      value: 'report'),
                                ],
                            onSelected: (dynamic value) {
                              if (value == "report") {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext cont) => ReportDialog(
                                    id: post!.id,
                                    reportType: Report.TYPE_POST,
                                    parentContext: context,
                                  ),
                                );
                              }
                            }) /*if (post.tags.length > 1)
                          Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: FlatButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      TagsDialog(post.id, post.tags),
                                );
                              },
                              color:
                                  AppThemeData.colorCard, //.swatchPrimary[50],
                              child: Icon(
                                Icons.more_horiz,
                                size: 15.0,
                                color: AppThemeData.colorControls,
                              ),
                              padding: EdgeInsets.all(12),
                              shape: CircleBorder(side: BorderSide.none),
                            ),
                          ),
                        if (post.tags.length > 0)
                          Chip(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            backgroundColor:
                                AppThemeData.colorCard, //.swatchPrimary[50],
                            label: Text(
                              '#' + post.tags[0],
                              style:
                                  TextStyle(color: AppThemeData.colorControls),
                            ),
                          ),*/
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(
                    post!.title! + "\n",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      if (post is Event) (getEventDateText(post as Event))
                    ],
                  ),
                )
              ],
            )),
        onTap: () {
          Navigator.push(context, PostPage.route(post));
        });
  }
}
