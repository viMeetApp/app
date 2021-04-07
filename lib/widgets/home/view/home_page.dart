import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/widgets/group_feed/groupfeed_page.dart';
import 'package:signup_app/widgets/home/cubit/home_page_cubit.dart';
import 'package:signup_app/widgets/home_feed/homefeed_page.dart';
import 'package:signup_app/widgets/login/view/login_page.dart';
import 'package:signup_app/widgets/message_feed/messagefeed_page.dart';
import 'package:signup_app/widgets/settings/view/settings_page.dart';

class HomePage extends StatelessWidget {
  final bool? initLoggedIn;
  static Route route({bool? loggedIn}) {
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
                      MessageFeed(),
                      SettingsPage()
                    ],
                  ),
                  bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(50, 50, 50, 0.06),
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
                                AssetImage('assets/img/brand/logo_icon.png'))),
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
                child: !state.loggedIn! ? LoginPage() : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
