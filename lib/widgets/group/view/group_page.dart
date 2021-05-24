import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/group/cubit/group_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/view/group_settings_page.dart';
import 'package:signup_app/widgets/group/view/widgets/group_status_button.dart';
import 'package:signup_app/widgets/post_editor/implementations/event_editor_page.dart';
import 'package:signup_app/widgets/post_list/implementations/filterable/post_list_filterable.dart';
import 'package:signup_app/widgets/shared/network_images/avatar/implementations/network_avatar_group.dart';

///Start Page For Group from here on decission if Member or not
class GroupPage extends StatelessWidget {
  final Group group;
  //Group is starter with an group because we already know the Group at this Position
  //Because of that we loose one fetch from Backend
  GroupPage({required this.group});

  static Route route({required Group group}) {
    return MaterialPageRoute<void>(
      builder: (_) => GroupPage(
        group: group,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupCubit>(
      create: (_) => GroupCubit(group: group),
      child: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
          return Scaffold(
            //appBar:
            body: SafeArea(
              child: Column(children: [
                Container(
                  color: Color(0xff84AFC0),
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      AppBar(
                        iconTheme: IconThemeData(
                            color: AppThemeData.colorTextInverted),
                        backgroundColor: Colors.transparent,
                        actions: [
                          // Group Settings Button
                          Container(
                            child: (state is GroupAdmin)
                                ? IconButton(
                                    icon: Icon(
                                      Icons.settings,
                                      color: AppThemeData.colorTextInverted,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          GroupSettingsPage.route(
                                              group: state.group,
                                              groupCubit:
                                                  BlocProvider.of<GroupCubit>(
                                                      context)));
                                    },
                                  )
                                : null,
                          ),
                          // more Button
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: AppThemeData.colorTextInverted,
                            ),
                            onPressed: () => Tools.showSnackbar(
                                context, "TODO: Melden/Info Dialog"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: AppThemeData.varPaddingNormal * 2,
                        right: AppThemeData.varPaddingNormal * 2,
                        bottom: AppThemeData.varPaddingNormal * 2),
                    decoration: BoxDecoration(
                        color: AppThemeData.colorCard,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: AppThemeData.varCardRadius,
                            bottomRight: AppThemeData.varCardRadius)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                transform:
                                    Matrix4.translationValues(0.0, -23.0, 0.0),
                                child: Hero(
                                  tag: "group_icon" + state.group.id,
                                  child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppThemeData.colorCard,
                                      child: NetworkAvatarGroup(
                                        radius: 45,
                                        imageUrl: group.picture,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20,
                                      top: AppThemeData.varPaddingCard * 1.5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.group.name,
                                        style: AppThemeData.textHeading1(),
                                        textAlign: TextAlign.left,
                                      ),
                                      Container(
                                          //width: double.infinity,
                                          margin: EdgeInsets.only(top: 10),
                                          child: GroupStatusButton()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(state.group.about,
                            style: AppThemeData.textNormal()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: (state is GroupMember)
                      ? PostListFilterableWidget(group: state.group)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.lock,
                                size: 30,
                              ),
                            ),
                            Text("Posts sind nur für Mitglieder sichtbar")
                          ],
                        ),
                )
              ]),
            ),
            floatingActionButton: (state is GroupMember)
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context, CreateEventPage.route(group: state.group));
                    },
                    child: Icon(
                      Icons.add,
                      color: AppThemeData.colorCard,
                    ),
                    backgroundColor: AppThemeData.colorPrimary,
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
