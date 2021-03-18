import 'package:flutter/material.dart';
import 'package:signup_app/widgets/bug_report/view/bug_report_page.dart';
import 'package:signup_app/widgets/home_feed/location_widget/view/location_widget.dart';
import 'package:signup_app/widgets/post_editor/implementations/create_post_page.dart';
import 'package:signup_app/widgets/post_list/view/post_list_widget.dart';
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
              icon: Icon(Icons.favorite),
              onPressed: () => {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("TODO: Favoriten")))
              },
              /*() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => GroupDropownWidget(),
                );
              },*/
            ),
          ),
          title: LocationWidget(),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.bug_report),
                onPressed: () =>
                    {Navigator.push(context, BugReportPage.route())},
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: PostList(
              filterable: true,
            ),
          ),
        ),
      ),
    ]);
  }
}
