import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/vibit/vibit.dart';
import 'package:signup_app/widgets/chat/chat.dart';
import 'package:signup_app/widgets/post_editor/implementations/update_post_page.dart';
import 'package:signup_app/widgets/post_page/cubit/post_page_vibit.dart';

class PostPage extends StatelessWidget {
  final Post post;
  PostPage(this.post);

  static Route route({required Post post}) {
    return MaterialPageRoute<void>(builder: (_) {
      return post is Event ? PostPage(post) : tempBuddyPage();
    });
  }

  static Widget tempBuddyPage() {
    return Scaffold(body: Center(child: Text("TODO: Buddy parsing")));
  }

  Widget getPostInfoWidget({required Post post}) {
    return Padding(
        padding: EdgeInsets.only(top: 10), child: Text("TODO: widget"));
  }

  Widget getSubscribeRow({required PostPageState state}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: state.subscribed
                ? OutlinedButton(
                    child: Text(
                      "abmelden",
                      style: AppThemeData.textNormal(),
                    ),
                    onPressed: () {
                      state.unsubscribe();
                    })
                : MaterialButton(
                    color: AppThemeData.colorPrimary,
                    child: Text("anmelden"),
                    onPressed: () {
                      state.subscribe();
                    }),
          ),
          if (state.subscribed)
            Expanded(flex: 1, child: Center(child: Text("x Teilnehmer")))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViBit<PostPageState>(
        state: PostPageState(post),
        onRefresh: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppThemeData.colorCard,
              actions: [
                if (state.postIsOwned())
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context, UpdatePostPage.route(post: state.post));
                    },
                  ),
                IconButton(
                  icon: Icon(
                      state.favorited ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    state.toggleFavorite();
                  },
                ),
                IconButton(
                  icon: Icon(
                      state.expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    state.toggleExpanded();
                  },
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    //height: state.expanded ? 500 : 0,
                    //constraints: BoxConstraints(),
                    decoration: new BoxDecoration(
                        color: AppThemeData.colorCard,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(20)),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey[400]!,
                            blurRadius: 20.0,
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          state.post.title,
                          style: AppThemeData.textHeading1(),
                        ),
                        if (state.expanded) getPostInfoWidget(post: state.post),
                        getSubscribeRow(state: state),
                      ],
                    )),
                ChatWidget(post: state.post),
              ],
            ),
          );
        });
  }
}
