import 'package:flutter/material.dart';
import 'package:signup_app/widgets/bug_report/view/bug_report_page.dart';
import 'package:signup_app/widgets/create_post/view/create_post_page.dart';
import 'package:signup_app/widgets/home_feed/location_dialog/location_dialog.dart';
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
              icon: Icon(Icons.event),
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
