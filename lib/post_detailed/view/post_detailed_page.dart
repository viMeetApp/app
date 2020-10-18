import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/authentication/bloc/authentication_bloc.dart';
import 'package:signup_app/chat/chat.dart';
import 'package:signup_app/post_detailed/cubit/post_detailed_cubit.dart';
import 'package:signup_app/util/DataModels.dart';

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
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
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
                  })
            ],
          ),
          body: SafeArea(
            child: Column(
                children: [
                  BlocDescription(),
                  ChatWidget(postId: post.id, user: user),
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
          return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(state.post.about),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: (state as EventState).isSubscribed == false
                            ? ElevatedButton(
                                onPressed: () {},
                                child: Text("anmelden"),
                              )
                            : ElevatedButton(
                                onPressed: () {},
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
              ));
        });
  }
}
