import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signup_app/authentication/bloc/authentication_bloc.dart';
import 'package:signup_app/chat/chat.dart';
import 'package:signup_app/post_detailed/cubit/post_detailed_cubit.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/util/signup_widgets.dart';

class PostDetailedPage extends StatelessWidget {
  static Route route(Post post) {
    return MaterialPageRoute<void>(
        builder: (_) => PostDetailedPage(
              post: post,
            ));
  }

  Post post;

  PostDetailedPage({@required this.post});
  @override
  Widget build(BuildContext context) {
    //!Problem das User in Repository und in Klasse doppelt defniert
    //ToDo vermutlich dieses User Repository auflösen hat für uns im Moment auch keinen wirklichen Zweck
    var help =
        (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated)
            .user;
    User user = User(name: help.name, uid: help.userid);

    return BlocProvider(
        create: (context) => PostdetailedCubit(post: post),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppThemeData.colorCard,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: BlocBuilder<PostdetailedCubit, PostDetailedState>(
                buildWhen: (previous, current) =>
                    previous.post.title != current.post.title,
                builder: (context, state) {
                  return Text(state.post.title);
                }),
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
          body: SafeArea(
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: [
                ChatWidget(postId: post.id, user: user),
                BlocDescription(),
              ],
            ),
          ),
        ));
    //Need To Wrap in Bloc Provider
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //Only Show Text when Expanded
                    if (state.isExpanded)
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(state.post.about, maxLines: 6)),

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: (state as EventState).isSubscribed == false
                              ? RaisedButton(
                                  onPressed: () {
                                    BlocProvider.of<PostdetailedCubit>(context)
                                        .subscribe();
                                  },
                                  child: Text("anmelden"),
                                )
                              : RaisedButton(
                                  color: AppThemeData.colorPlaceholder,
                                  onPressed: () {
                                    BlocProvider.of<PostdetailedCubit>(context)
                                        .unsubscribe();
                                  },
                                  child: Text("abmelden"),
                                ),
                        ),

                        //Text in Row 9/12 Teilnehmer
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
