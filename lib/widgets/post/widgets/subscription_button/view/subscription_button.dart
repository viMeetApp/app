import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/post/cubit/post_cubit.dart';
import 'package:signup_app/widgets/post/widgets/subscription_button/cubit/subscription_cubit.dart';

class SubscriptionButton extends StatelessWidget {
  final SubscriptionCubit subscriptionCubit = SubscriptionCubit();
  @override
  Widget build(BuildContext context) {
    EventState state = BlocProvider.of<PostCubit>(context).state as EventState;
    return Text("TODO: Reenable Button");
    /*return BlocListener<SubscriptionCubit, SubscriptionState>(
      cubit: subscriptionCubit,
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
      child: Expanded(
        flex: 1,
        child: state.isSubscribed == false
            ? RaisedButton(
                onPressed: () {
                  subscriptionCubit.subscribe(postId: state.post.id);
                },
                child: Text("anmelden"),
              )
            : RaisedButton(
                color: AppThemeData.colorPlaceholder,
                //The creator of a post can not unsubscribe from the post
                onPressed: !state.isAuthor
                    ? () => subscriptionCubit.unsubscribe(postId: state.post.id)
                    : null,
                child: Text("abmelden"),
              ),
      ),
    );*/
  }
}
