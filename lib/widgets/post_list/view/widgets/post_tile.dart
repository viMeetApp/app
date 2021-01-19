import 'package:flutter/material.dart';
import 'package:signup_app/widgets/post_detailed/view/post_detailed_page.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/post_list/view/widgets/tags_dialog.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final bool highlight;

  PostTile({@required this.post, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 120,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                color:
                    /*(post.group != null && highlight)
                    ? AppThemeData.swatchPrimary[20]
                    : AppThemeData.colorCard,*/
                    AppThemeData.colorCard,
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
                              this.post.author.name,
                              style: TextStyle(
                                  color: AppThemeData.colorTextRegularLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                            padding: EdgeInsets.only(left: 5)),
                        if (this.post.group != null)
                          Row(children: [
                            Text(
                              "  in  ",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              this.post.group.name,
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
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          padding: const EdgeInsets.only(left: 10),
                          visualDensity: VisualDensity.compact,
                          color: AppThemeData.colorControlsDisabled,
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("TODO: Weitere Optionen")));
                          },
                        )
                        /*if (post.tags.length > 1)
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
                    post.title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      if (post is Event)
                        (Text("TODO: Event"))
                      else
                        (Text("TODO: Buddy"))
                    ],
                  ),
                )*/
              ],
            )),
        onTap: () {
          Navigator.push(context, PostDetailedPage.route(post));
        });
  }
}
