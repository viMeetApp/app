import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';

class PostSettingsPage extends StatelessWidget {
  final Post post;
  PostSettingsPage({required this.post});
  static Route route({required Post post}) {
    return MaterialPageRoute<void>(
        builder: (_) => PostSettingsPage(
              post: post,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
