import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/authentication/bloc/authentication_bloc.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/chat/view/chat_widget.dart';
import 'package:signup_app/widgets/post_detailed/cubit/post_detailed_cubit.dart';
import 'package:signup_app/widgets/post_detailed/cubit/subscription_cubit.dart';
import 'package:signup_app/widgets/post_detailed/view/widgets/post_details_infosection.dart';

class PostDetailedPage extends StatelessWidget {
  static Route route(Post post) {
    return MaterialPageRoute<void>(builder: (_) {
      //TODO Fix buddy parsing. Ignoring buddies:
      if (post is Buddy) {
        return Scaffold(body: Center(child: Text("TODO: Buddy parsing")));
      }

      return PostDetailedPage(
        post: post,
      );
    });
  }

  Post post;

  PostDetailedPage({@required this.post});
  @override
  Widget build(BuildContext context) {
    //Das ist eine schöne Version an User zu kommen ohne Netzwerkcall zu machen
    User user =
        (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated)
            .user;
    print("post: " + post.toDoc().toString());
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostdetailedCubit>(
          create: (context) => PostdetailedCubit(post: post),
        ),
        BlocProvider<SubscriptionCubit>(
          create: (context) => SubscriptionCubit(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppThemeData.colorCard,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(" "),
          /*BlocBuilder<PostdetailedCubit, PostDetailedState>(
              buildWhen: (previous, current) =>
                  previous.post.title != current.post.title,
              builder: (context, state) {
                return Text(state.post.title);
              })*/
          actions: [
            //Favourite Icon Button
            BlocBuilder<PostdetailedCubit, PostDetailedState>(
                buildWhen: (previous, current) =>
                    previous.isFavourite != current.isFavourite,
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(state.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      BlocProvider.of<PostdetailedCubit>(context).favourite();
                    },
                  );
                }),

            //Expand Icon Button
            BlocBuilder<PostdetailedCubit, PostDetailedState>(
                buildWhen: (previous, current) =>
                    previous.isExpanded != current.isExpanded,
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(state.isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more),
                    onPressed: () {
                      BlocProvider.of<PostdetailedCubit>(context)
                          .toggleExpanded();
                    },
                  );
                })
          ],
        ),
        body: BlocListener<SubscriptionCubit, SubscriptionState>(
          listener: (context, state) {
            if (state.error) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Fehler beim Anmelden. Prüfe deine Verbindung'),
                ));
            } else if (state.subscribing) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Anmdelden'),
                ));
            } else if (state.unsubscribing) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Abmelden'),
                ));
            }
          },
          child: SafeArea(
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: [
                ChatWidget(postId: post.id, user: user),
                BlocDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//!Achtung
//Ich trenne hier alle Widgets in eigene Bereiche auf, damit nicht immer der ganz Screen neu gebaut werden muss.
//Insbesondere der Chat soll so bleiben wie er ist

//Der Bereich mit Beschreibung
class BlocDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostdetailedCubit, PostDetailedState>(
        buildWhen: (previous, current) =>
            previous.post.about != current.post.title ||
            (previous as EventState).isSubscribed !=
                (current as EventState).isSubscribed,
        builder: (context, state) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: new BoxDecoration(
                color: AppThemeData.colorCard,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 20.0,
                  ),
                ]),
            //borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            child: Container(
                padding: const EdgeInsets.only(
                    bottom: 20, top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        state.post.title,
                        style: AppThemeData.textHeading2(),
                      ),
                    ),
                    //Only Show Text when Expanded
                    if (state.isExpanded)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: InfoSection(state.post),
                      ),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: (state as EventState).isSubscribed == false
                              ? RaisedButton(
                                  onPressed: () {
                                    BlocProvider.of<SubscriptionCubit>(context)
                                        .subscribe(postId: state.post.id);
                                  },
                                  child: Text("anmelden"),
                                )
                              : RaisedButton(
                                  color: AppThemeData.colorPlaceholder,
                                  onPressed: () {
                                    BlocProvider.of<SubscriptionCubit>(context)
                                        .unsubscribe(postId: state.post.id);
                                  },
                                  child: Text("abmelden"),
                                ),
                        ),

                        //Text in Row 9/12 Teilnehmer
                        if ((state.post as Event).maxPeople != -1)
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                  "${(state.post as Event).participants.length}/${(state.post as Event).maxPeople} Teilnehmer"),
                            ),
                          ),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
