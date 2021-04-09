import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/group/cubit/group_cubit.dart';
import 'package:signup_app/widgets/group/group_settings/view/group_settings_page.dart';
import 'package:signup_app/widgets/post_editor/implementations/event_editor_page.dart';
import 'package:signup_app/widgets/post_list/view/post_list_widget.dart';
import 'package:signup_app/util/presets/presets.dart';

///This is the view for actual Members of the Group
///Only Member can post and see posts
class GroupPageContent extends StatelessWidget {
  Widget progressIndicator(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(accentColor: AppThemeData.colorPrimaryLight),
      child: Container(
          padding: EdgeInsets.all(10),
          height: 48.0,
          width: 60.0,
          child: Center(
              child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(strokeWidth: 3)))),
    );
  }

  Widget cancelRequestDialog(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(10),
      title: Text("Anfrage zurückziehen?"),
      content:
          Text("Möchtest du deine Beitritts-Anfrage wirklich zurückziehen?"),
      actions: [
        FlatButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text("nein")),
        RaisedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              BlocProvider.of<GroupCubit>(context).withdrawJoinRequest();
            },
            child: Text("ja"))
      ],
    );
  }

  final GroupState state;
  GroupPageContent({required this.state});
  @override
  Widget build(BuildContext context) {
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
                  iconTheme:
                      IconThemeData(color: AppThemeData.colorTextInverted),
                  backgroundColor: Colors.transparent,
                  actions: [
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
                                        group: state.group));
                              })
                          : null,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: AppThemeData.colorTextInverted,
                        ),
                        onPressed: () => {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("TODO: Melden/Info Dialog")))
                            })
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
                          transform: Matrix4.translationValues(0.0, -23.0, 0.0),
                          child: Hero(
                            tag: "group_icon" + state.group.id,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: AppThemeData.colorCard,
                              child: CircleAvatar(
                                backgroundColor: AppThemeData.colorPlaceholder,
                                backgroundImage:
                                    AssetImage("assets/img/exampleImage2.jpg"),
                                radius: 45,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20,
                                top: AppThemeData.varPaddingCard * 1.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.group.name,
                                  style: AppThemeData.textHeading1(),
                                  textAlign: TextAlign.left,
                                ),
                                Container(
                                  //width: double.infinity,
                                  margin: EdgeInsets.only(top: 10),
                                  child: (state is NotGroupMember)
                                      ? (state as NotGroupMember)
                                              .requestedToJoin
                                          ? OutlineButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          cancelRequestDialog(
                                                              context),
                                                );
                                              },
                                              child: Text("angefragt"),
                                              borderSide: BorderSide(
                                                  color: AppThemeData
                                                      .colorPrimaryLight))
                                          : (state as NotGroupMember).requesting
                                              ? progressIndicator(context)
                                              : RaisedButton(
                                                  onPressed: () => BlocProvider
                                                          .of<GroupCubit>(
                                                              context)
                                                      .requestToJoinGroup(),
                                                  child: Text("beitreten"))
                                      : OutlineButton(
                                          color: AppThemeData.colorControls,
                                          textColor: AppThemeData.colorControls,
                                          onPressed: () => {},
                                          child: Text("austreten"),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(state.group.about, style: AppThemeData.textNormal()),
                ],
              ),
            ),
          ),
          Expanded(
            child: (state is GroupMember)
                ? PostList(
                    filterable: true,
                    group: state.group,
                  )
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
