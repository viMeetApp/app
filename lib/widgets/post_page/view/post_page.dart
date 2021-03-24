import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/repositories/post_repository.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/util/tools.dart';
import 'package:signup_app/vibit/vibit.dart';
import 'package:signup_app/widgets/chat/chat.dart';
import 'package:signup_app/widgets/post_editor/implementations/update_post_page.dart';
import 'package:signup_app/widgets/post_page/cubit/post_page_vibit.dart';

class PostPage extends StatelessWidget {
  final String _postID;
  PostPage(this._postID);

  static Route route({required Post post}) {
    return MaterialPageRoute<void>(builder: (_) {
      return post is Event ? PostPage(post.id ?? "") : tempBuddyPage();
    });
  }

  static Widget tempBuddyPage() {
    return Scaffold(body: Center(child: Text("TODO: Buddy parsing")));
  }

  Widget getPostInfoWidget({required Event event}) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: ListView(
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(event.about ?? ""),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Text(Tools.dateFromEpoch(event.eventDate ?? 0),
                              style: AppThemeData.textNormal(
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text(Tools.timeFromEpoch(event.eventDate ?? 0),
                              style: AppThemeData.textNormal(
                                  fontWeight: FontWeight.bold))),
                    ]),
              ),
              if (event.details.length > 0)
                Divider(
                  color: AppThemeData.colorControlsDisabled,
                  thickness: 1,
                ),
              for (PostDetail? detail in event.details)
                if (detail != null) getPostDetailView(detail),
              if (event.details.length > 0)
                Divider(
                  color: AppThemeData.colorControlsDisabled,
                  thickness: 1,
                ),
            ],
          )),
    );
  }

  Widget getPostDetailView(PostDetail detail) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child:
                  Text(PostRepository.titleFromPostDetailID(detail.id) + ":")),
          Expanded(
              child: Text(
            detail.value,
            style: AppThemeData.textNormal(fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }

  Widget getSubscribeRow({required PostPageState state}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: state.processing
                ? Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : state.subscribed
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
          Expanded(
              flex: 1,
              child: Center(
                  child: Text("${(state.post as Event).participants!.length}" +
                      (((state.post as Event).maxPeople ?? 0) > 0
                          ? "/${(state.post as Event).maxPeople}"
                          : "") +
                      " Teilnehmende")))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViBit<PostPageState>(
        state: PostPageState(_postID),
        onRefresh: (context, state) {
          if (state.post is Event) {
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
                  if (state.postIsOwned())
                    IconButton(
                      icon: Icon(Icons.people),
                      onPressed: () {
                        Tools.showSnackbar(context, "TODO: Show Teilnehmer");
                      },
                    ),
                  IconButton(
                    icon: Icon(state.favorited
                        ? Icons.favorite
                        : Icons.favorite_border),
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
                  Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.all(20),
                        //height: state.expanded ? 500 : 0,
                        //constraints: BoxConstraints(),
                        decoration: new BoxDecoration(
                            color: AppThemeData.colorCard,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20)),
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
                            if (state.expanded)
                              getPostInfoWidget(event: state.post as Event),
                            getSubscribeRow(state: state),
                          ],
                        )),
                  ),
                  ChatWidget(
                      post: state.post,
                      onTap: () {
                        state.foldIn();
                      }),
                ],
              ),
            );
          } else {
            return tempBuddyPage();
          }
        });
  }
}
