import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/groupfeed/groupfeed_page.dart';
import 'package:signup_app/home/cubit/home_page_cubit.dart';
import 'package:signup_app/homefeed/homefeed_page.dart';
import 'package:signup_app/login/view/login_page.dart';
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

  HomePage({this.initLoggedIn = false});

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
                DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    body: TabBarView(
                      children: [
                        HomeFeed(),
                        GroupFeed(),
                        Center(child: Text("TODO: Nachrrichten")),
                        SettingsPage()
                      ],
                    ),
                    /*floatingActionButton: (state.currentPage != 0)
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
                        FloatingActionButtonLocation.endDocked,*/
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(0, 1),
                              blurRadius: 2.0,
                              spreadRadius: 2.0)
                        ],
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      child: TabBar(
                        labelPadding: EdgeInsets.all(8),
                        indicatorColor: Colors.transparent,
                        labelColor: AppThemeData.colorPrimary,
                        unselectedLabelColor: AppThemeData.colorControls,
                        tabs: [
                          Tab(
                              icon: ImageIcon(
                                  AssetImage('assets/img/logo_icon.png'))),
                          Tab(icon: Icon(Icons.group)),
                          Tab(icon: Icon(Icons.chat_bubble)),
                          Tab(icon: Icon(Icons.menu)),
                        ],
                      ),
                    ),
                  ),
                ),
                /*AnimatedContainer(
                  //color: Colors.white,
                  duration: Duration(milliseconds: 100),
                  child: state.showGroups ? groupDropdownWidget : null,
                ),*/
                AnimatedContainer(
                  //color: Colors.white,
                  duration: Duration(milliseconds: 100),
                  child: !state.loggedIn ? LoginPage() : null,
                ),
              ],
            );
          },
        ));
  }
}
