import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/post/cubit/post_cubit.dart';
import 'package:signup_app/widgets/post/view/widgets/post_details_infosection.dart';
import 'package:signup_app/widgets/post/widgets/subscription_button/view/subscription_button.dart';

class DropdownCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
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
            child: Container(
                padding: const EdgeInsets.only(
                    bottom: 20, top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    showPostTitle(state),
                    if (state.isExpanded) showDetailedInformation(state),
                    Row(
                      children: [
                        SubscriptionButton(),
                        if ((state.post as Event).maxPeople != -1)
                          showNumbersOfParticipants(state)
                      ],
                    )
                  ],
                )),
          );
        });
  }

  Widget showPostTitle(PostState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        state.post.title,
        style: AppThemeData.textHeading2(),
      ),
    );
  }

  Widget showDetailedInformation(PostState state) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: InfoSection(state.post),
    );
  }

  Widget showNumbersOfParticipants(PostState state) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
            "${(state.post as Event).participants.length}/${(state.post as Event).maxPeople} Teilnehmende"),
      ),
    );
  }
}
