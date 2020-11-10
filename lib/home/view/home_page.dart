import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/creat_post.dart';
import 'package:signup_app/group/view/group_page.dart';
import 'package:signup_app/home/cubit/home_page_cubit.dart';
import 'package:signup_app/home/group_dropdown_widget/view/group_dropdown_widget.dart';
import 'package:signup_app/postList/post_list.dart';
import 'package:signup_app/util/presets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  final groupDropdownWidget = GroupDropownWidget();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageCubit>(
        create: (context) => HomePageCubit(),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    leading: Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.group),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                GroupDropownWidget(),
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
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("TODO: Gespeicherte Posts")))
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
                      if (number == 2) {
                        Navigator.push(context, GroupPage.route());
                      }
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
              ],
            );
          },
        ));
  }
}
