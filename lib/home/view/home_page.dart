import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/postList/post_list.dart';
import 'package:signup_app/post_detailed/cubit/post_detailed_cubit.dart';
import 'package:signup_app/util/Presets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.group),
            onPressed: () => {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("TODO: GruppenMenü")))
            },
          ),
        ),
        title: Text("TODO: Location"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.chat_bubble),
              onPressed: () => {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("TODO: Gespeicherte Posts")))
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: PostListView(),
        ),
      ),
    );
  }
}
