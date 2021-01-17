import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/post/cubit/post_cubit.dart';

class ActionButtons {
  static List<Widget> getActionButtons() {
    return [
      //!Different Bloc Builder are required because it returns list of widgets

      //Favourite Icon Button
      BlocBuilder<PostCubit, PostState>(
        buildWhen: (previous, current) =>
            previous.isFavourite != current.isFavourite,
        builder: (context, state) {
          return IconButton(
            icon: Icon(
                state.isFavourite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              BlocProvider.of<PostCubit>(context).favourite();
            },
          );
        },
      ),
      //Settings
      BlocBuilder<PostCubit, PostState>(
        buildWhen: (previous, current) => previous.isAuthor != current.isAuthor,
        builder: (context, state) {
          if (!state.isAuthor) return Container();
          return IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          );
        },
      ),
      //Expand Icon Button
      BlocBuilder<PostCubit, PostState>(
        buildWhen: (previous, current) =>
            previous.isExpanded != current.isExpanded,
        builder: (context, state) {
          return IconButton(
            icon:
                Icon(state.isExpanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              BlocProvider.of<PostCubit>(context).toggleExpanded();
            },
          );
        },
      ),
    ];
  }
}
