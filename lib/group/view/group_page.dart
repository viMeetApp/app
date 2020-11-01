import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/view/create_post_page.dart';
import 'package:signup_app/group/cubit/group_cubit.dart';
import 'package:signup_app/postList/view/post_list_view.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';

class GroupPage extends StatelessWidget {
  final Group group;
  GroupPage({@required this.group});

  static Route route({@required Group group}) {
    return MaterialPageRoute<void>(
        builder: (_) => GroupPage(
              group: group,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupCubit>(
      create: (_) => GroupCubit(group: group),
      child: BlocBuilder<GroupCubit, GroupState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppThemeData.colorControls),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: AppThemeData.colorControls,
                  ),
                  onPressed: null)
            ],
          ),
          body: SafeArea(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: AppThemeData.colorPlaceholder,
                          backgroundImage: AssetImage(
                              "assets/img/logo_light_text_trans.png"),
                          maxRadius: 50,
                          minRadius: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.all(AppThemeData.varPaddingEdges),
                      child: Presets.getSignUpCard(
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 10,
                          children: [
                            Text(
                              state.group.name,
                              style: AppThemeData.textHeading2,
                              textAlign: TextAlign.center,
                            ),
                            Text(state.group.about),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RaisedButton(
                                  onPressed: () => {},
                                  child: Text("beitreten"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PostListView(
                  group: state.group,
                ),
              ),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, CreatePostPage.route(group: state.group));
            },
            child: Icon(
              Icons.add,
              color: AppThemeData.colorCard,
            ),
            backgroundColor: AppThemeData.colorPrimary,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        );
      }),
    );
  }
}
