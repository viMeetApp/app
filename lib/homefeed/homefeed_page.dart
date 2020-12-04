import 'package:flutter/material.dart';
import 'package:signup_app/home/group_dropdown_widget/view/group_dropdown_widget.dart';
import 'package:signup_app/postList/view/post_list_view.dart';

class HomeFeed extends StatelessWidget {
  final bool initLoggedIn;
  static Route route({bool loggedIn}) {
    return MaterialPageRoute<void>(
        builder: (_) => HomeFeed(
              initLoggedIn: loggedIn,
            ));
  }

  final groupDropdownWidget = GroupDropownWidget();

  HomeFeed({this.initLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => GroupDropownWidget(),
              );
              //BlocProvider.of<HomePageCubit>(context)
              //    .openGroups(context);
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
