import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/create_post/creat_post.dart';
import 'package:signup_app/postList/post_list.dart';
import 'package:signup_app/util/Presets.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex;

  void initState() {
    super.initState();
    currentPageIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentPageIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: AppThemeData.colorPrimary,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: AppThemeData.colorPrimary,
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: AppThemeData.colorPrimary,
              ),
              title: Text("Favoriten")),
          BubbleBottomBarItem(
              backgroundColor: AppThemeData.colorPrimary,
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.menu,
                color: AppThemeData.colorPrimary,
              ),
              title: Text("Menu"))
        ],
      ),
    );
  }
}
