import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/post/cubit/post_cubit.dart';

class ActionButtons {
  static List<Widget> getActionButtons() {
    return [
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
          }),

      //Expand Icon Button
      BlocBuilder<PostCubit, PostState>(
          buildWhen: (previous, current) =>
              previous.isExpanded != current.isExpanded,
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                  state.isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                BlocProvider.of<PostCubit>(context).toggleExpanded();
              },
            );
          })
    ];
  }
}
