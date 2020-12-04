import 'package:flutter/material.dart';
import 'package:signup_app/create_post/view/create_post_page.dart';
import 'package:signup_app/home/group_dropdown_widget/view/group_dropdown_widget.dart';
import 'package:signup_app/postList/view/post_list_view.dart';
import 'package:signup_app/util/presets.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CreatePostPage.route());
        },
        child: Icon(
          Icons.add,
          color: AppThemeData.colorCard,
        ),
        backgroundColor: AppThemeData.colorPrimary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              icon: Icon(Icons.favorite),
              onPressed: () => {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("TODO: Favoriten")))
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
