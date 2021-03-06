import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/util/widgets/network_buttons/vi_network_material_button.dart';
import 'package:signup_app/vibit/vibit.dart';
import 'package:signup_app/widgets/chat/chat.dart';
import 'package:signup_app/widgets/post_editor/implementations/update_post_page.dart';
import 'package:signup_app/widgets/post_page/cubit/post_page_vibit.dart';
import 'package:signup_app/widgets/post_page/view/post_members_page.dart';

class PostPage extends StatelessWidget {
  final Post _post;
  PostPage({required Post post}) : _post = post;

  static Route route({required Post post}) {
    return MaterialPageRoute<void>(builder: (_) {
      return post is Event
          ? PostPage(
              post: post,
            )
          : tempBuddyPage();
    });
  }

  static Widget tempBuddyPage() {
    return Scaffold(body: Center(child: Text("TODO: Buddy parsing")));
  }

  Widget getPostInfoWidget({required Event event}) {
    List<Widget> _detailFields = [
      if (event.maxParticipants != null && event.maxParticipants != -1)
        eventFieldView('Max. Teilnehmende', event.maxParticipants.toString()),
      if (event.costs != null) eventFieldView('Kosten', event.costs.toString()),
      if (event.eventLocation != null)
        eventFieldView('Ort', event.eventLocation!),
    ];

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            if (event.about != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(event.about!),
              ),
            if (event.eventAt != null)
              Container(
                padding: const EdgeInsets.only(bottom: 15.0, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Text(Tools.dateFromEpoch(event.eventAt!),
                              style: AppThemeData.textNormal(
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text(Tools.timeFromEpoch(event.eventAt!),
                              style: AppThemeData.textNormal(
                                  fontWeight: FontWeight.bold))),
                    ]),
              ),
            if (_detailFields.length > 0) ...{
              Divider(
                color: AppThemeData.colorControlsDisabled,
                thickness: 1,
              ),
              ..._detailFields,
              Divider(
                color: AppThemeData.colorControlsDisabled,
                thickness: 1,
              ),
            }
          ],
        ),
      ),
    );
  }

  Widget eventFieldView(String name, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Text(name + ":")),
          Expanded(
              child: Text(
            content,
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
            child: state.subscribed
                ? ViNetworkOutlinedButton(
                    onPressed: () => state.unsubscribe(),
                    child: Text(
                      "abmelden",
                      style: AppThemeData.textNormal(),
                    ),
                  )
                : ViNetworkMaterialButton(
                    onPressed: () => state.subscribe(),
                    child: Text("anmelden"),
                    color: AppThemeData.colorPrimary),
          ),
          Expanded(
              flex: 1,
              child: Center(
                  child: Text("${(state.post as Event).participants?.length}" +
                      (((state.post as Event).maxParticipants ?? 0) > 0
                          ? "/${(state.post as Event).maxParticipants}"
                          : "") +
                      " Teilnehmende")))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViBit<PostPageState>(
        state: PostPageState(post: _post),
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
                  IconButton(
                    icon: Icon(Icons.people),
                    onPressed: () {
                      Navigator.push(context,
                          PostMembersPage.route(event: (state.post as Event)));
                    },
                  ),
                  IconButton(
                    icon: Icon(state.favorited
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      state.toggleFavorite();
                      Tools.showSnackbar(context, "TODO: FavLogic");
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
                    flex: state.expanded ? 1 : 0,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 10),
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
                  if (!state.expanded)
                    ChatWidget(
                      post: state.post,
                    ),
                ],
              ),
            );
          } else {
            return tempBuddyPage();
          }
        });
  }
}
