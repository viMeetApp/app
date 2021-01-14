import 'package:flutter/material.dart';
import 'package:signup_app/widgets/post_detailed/view/post_detailed_page.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/post_list/view/widgets/tags_dialog.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({@required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            //height: 130,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                color: Theme.of(context).cardColor,
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
                          (post.group != null ? Icons.group : Icons.person),
                          size: 20,
                          color: AppThemeData.colorTextRegularLight,
                        ),
                        Container(
                            child: Text(
                              (this.post.group != null
                                  ? this.post.group.name
                                  : this.post.author.name),
                              style: TextStyle(
                                  color: AppThemeData.colorTextRegularLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.only(left: 5)),
                      ]),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (post.tags.length > 0)
                          Chip(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                            backgroundColor: Colors.grey[350],
                            label: Text(
                              '#' + post.tags[0],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        if (post.tags.length > 1)
                          Padding(
                            padding: EdgeInsets.only(left: 6),
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
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.more_horiz,
                                size: 15.0,
                                color: AppThemeData.colorCard,
                              ),
                              padding: EdgeInsets.all(12),
                              shape: CircleBorder(side: BorderSide.none),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    post.title,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      if (post is Event)
                        (Text("TODO: Event"))
                      else
                        (Text("TODO: Buddy"))
                    ],
                  ),
                )
              ],
            )),
        onTap: () {
          Navigator.push(context, PostDetailedPage.route(post));
        });
  }
}
