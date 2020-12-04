import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/creat_post.dart';
import 'package:signup_app/group/view/group_page.dart';
import 'package:signup_app/home/cubit/home_page_cubit.dart';
import 'package:signup_app/home/group_dropdown_widget/view/group_dropdown_widget.dart';
import 'package:signup_app/homefeed/homefeed_page.dart';
import 'package:signup_app/login/view/login_page.dart';
import 'package:signup_app/postList/post_list.dart';
import 'package:signup_app/settings/view/settings_page.dart';
import 'package:signup_app/util/presets.dart';

class HomePage extends StatelessWidget {
  final bool initLoggedIn;
  static Route route({bool loggedIn}) {
    return MaterialPageRoute<void>(
        builder: (_) => HomePage(
              initLoggedIn: loggedIn,
            ));
  }

  final groupDropdownWidget = GroupDropownWidget();

  HomePage({this.initLoggedIn = false});

  Widget _getCurrentPage(int index) {
    switch (index) {
      case 0:
        return HomeFeed();
      case 1:
        return Center(child: Text("TODO: Fav"));
      case 2:
        return SettingsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
        create: (context) => HomePageCubit(initLoggedIn),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            // theming the bottom bar
            /*SystemChrome.setSystemUIOverlayStyle(state.loggedIn
                ? AppThemeData.uiOverlayStyle
                : AppThemeData.uiOverlayStyleThemed);*/

            return Stack(
              children: [
                Scaffold(
                  body: _getCurrentPage(state.currentPage),
                  floatingActionButton: (state.currentPage != 0)
                      ? null
                      : FloatingActionButton(
                          onPressed: () {
                            Navigator.push(context, CreatePostPage.route());
                          },
                          child: Icon(
                            Icons.add,
                            color: AppThemeData.colorCard,
                          ),
                          backgroundColor: AppThemeData.colorPrimary,
                        ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endDocked,
                  bottomNavigationBar: BubbleBottomBar(
                    opacity: .2,
                    currentIndex: state.currentPage,
                    //onTap
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    elevation: 8,
                    fabLocation: BubbleBottomBarFabLocation.end, //new
                    hasNotch: true, //new
                    hasInk: true, //new, gives a cute ink effect
                    onTap: (number) {
                      BlocProvider.of<HomePageCubit>(context)
                          .setCurrentPage(number);
                    },
                    inkColor: Colors
                        .black12, //optional, uses theme color if not specified
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
                ),
                AnimatedContainer(
                  // color: Colors.white,
                  duration: Duration(milliseconds: 100),
                  child: state.showGroups ? groupDropdownWidget : null,
                ),
                AnimatedContainer(
                  // color: Colors.white,
                  duration: Duration(milliseconds: 100),
                  child: !state.loggedIn ? LoginPage() : null,
                ),
              ],
            );
          },
        ));
  }
}
