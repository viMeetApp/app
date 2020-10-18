import 'package:flutter/material.dart';
import 'package:signup_app/postList/post_list.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Center(
          child: PostListView(),
        ),
      ),
    );
  }
}
