import 'package:flutter/material.dart';
import 'package:signup_app/post_detailed/view/post_detailed_page.dart';
import 'package:signup_app/util/DataModels.dart';
import 'package:signup_app/util/Presets.dart';

class PostTile extends StatelessWidget {
  Post post;

  PostTile({@required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 130,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(AppThemeData().varCardRadius)),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(children: [
                              Icon(
                                (post.groupID != null
                                    ? Icons.group
                                    : Icons.person),
                                size: 17,
                                color: AppThemeData().colorControls,
                              ),
                              Container(
                                  child: Text(
                                    /*
                                (this.post.group != null
                                    ? this.post.group.name
                                    : this.post.author.name)*/
                                    "TODO: GroupName",
                                    style: TextStyle(
                                        color: AppThemeData().colorControls),
                                  ),
                                  padding: EdgeInsets.only(left: 5)),
                            ]),
                          ),
                          Row(
                            children: [
                              Text(
                                post.title,
                                //softWrap: true,
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ],
                          ),
                        ]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (post.tags.length > 0)
                          Chip(
                            backgroundColor: Colors.red[300],
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
                              //visualDensity: VisualDensity.compact,
                              onPressed: () {},
                              color: AppThemeData().swatchPrimary[200],
                              child: Icon(
                                Icons.more_horiz,
                                size: 15.0,
                                color: AppThemeData().colorCard,
                              ),
                              padding: EdgeInsets.all(6),
                              shape: CircleBorder(side: BorderSide.none),
                            ),
                          )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (post is Event)
                      (Text("TODO: Event"))
                    else
                      (Text("TODO: Buddy"))
                  ],
                )
              ],
            )),
        onTap: () {
          Navigator.push(context, PostDetailedPage.route(post));
        });
  }
}
