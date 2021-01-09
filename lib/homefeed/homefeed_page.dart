import 'package:flutter/material.dart';
import 'package:signup_app/create_post/view/create_post_page.dart';
import 'package:signup_app/homefeed/location_dialog/location_dialog.dart';
import 'package:signup_app/postList/implementations/filterablePostList.dart';
import 'package:signup_app/util/presets.dart';

class HomeFeed extends StatelessWidget {
  final bool initLoggedIn;
  static Route route({bool loggedIn}) {
    return MaterialPageRoute<void>(
        builder: (_) => HomeFeed(
              initLoggedIn: loggedIn,
            ));
  }

  //final groupDropdownWidget = GroupDropownWidget();

  HomeFeed({this.initLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
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
              icon: Icon(Icons.calendar_today),
              onPressed: () => {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("TODO: Kalender-View")))
              },
              /*() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => GroupDropownWidget(),
                );
              },*/
            ),
          ),
          title: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                Text(
                  "Freiburg",
                  style: AppThemeData.textHeading2(),
                ),
              ],
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => LocationDialog(),
              );
              //BlocProvider.of<HomePageCubit>(context)
              //    .openGroups(context);
            },
          ),
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
            child: FilterablePostList(),
          ),
        ),
      ),
    ]);
  }
}
