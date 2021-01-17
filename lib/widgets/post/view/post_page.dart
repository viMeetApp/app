import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/authentication/bloc/authentication_bloc.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/chat/view/chat_widget.dart';
import 'package:signup_app/widgets/post/cubit/post_cubit.dart';
import 'package:signup_app/widgets/post/cubit/subscription_cubit.dart';
import 'package:signup_app/widgets/post/view/widgets/action_buttons.dart';
import 'package:signup_app/widgets/post/view/widgets/dropdown_card.dart';

class PostPage extends StatelessWidget {
  static Route route(Post post) {
    return MaterialPageRoute<void>(builder: (_) {
      //TODO Fix buddy parsing. Ignoring buddies:
      if (post is Buddy) {
        return Scaffold(body: Center(child: Text("TODO: Buddy parsing")));
      }

      return PostPage(
        post: post,
      );
    });
  }

  final Post post;

  PostPage({@required this.post});

  @override
  Widget build(BuildContext context) {
    //Das ist eine schöne Version an User zu kommen ohne Netzwerkcall zu machen
    User user =
        (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated)
            .user;
    print("post: " + post.toDoc().toString());
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (context) => PostCubit(post: post),
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
            title: Text("Post"),
            actions: ActionButtons.getActionButtons()),
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
                  content: Text('Anmelden'),
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
              children: [
                DropdownCard(),
                ChatWidget(post: post, user: user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
