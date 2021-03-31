import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/vibit/vibit.dart';
import 'package:signup_app/widgets/group_creator/cubit/group_creator_vibit.dart';

class GroupCreatorPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => GroupCreatorPage());
  }

  @override
  Widget build(BuildContext context) {
    return ViBit<GroupCreatorState>(
        state: GroupCreatorState(),
        onBuild: (context, state) {
          //Tools.showSnackbar(context, "wird veröffentlicht");
          return Scaffold(
              backgroundColor: AppThemeData.colorPrimary,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                iconTheme: IconThemeData(color: AppThemeData.colorTextInverted),
                title: Text("neue Gruppe erstellen",
                    style: AppThemeData.textHeading2(
                        color: AppThemeData.colorTextInverted)),
                backgroundColor: AppThemeData.colorPrimary,
              ),
              body: Container(
                color: AppThemeData.colorCard,
                child: SizedBox.expand(
                  child: SingleChildScrollView(
                    child: ViBitDynamic(
                        state: state,
                        onChangeLogic: () {
                          print("state: ${state.type}");
                          switch (state.type) {
                            case Types.error:
                              Tools.showSnackbar(
                                  context, "Fehler: ${state.error}");
                              break;
                            case Types.invalid:
                              print("invalid");
                              Tools.showSnackbar(
                                  context, "bitte alles ausfüllen");
                              break;
                            case Types.processing:
                              Tools.showSnackbar(
                                  context, "wird veröffentlicht");
                              break;
                            case Types.submitted:
                              Tools.showSuccessPage(context,
                                  message: "Gruppe wurde erstellt");
                              break;
                            default:
                          }
                        },
                        onRefresh: (context) {
                          return Column(
                            //direction: Axis.vertical,
                            children: [
                              Theme(
                                  data: ThemeData.dark(),
                                  child: Container(
                                      color: AppThemeData.colorPrimary,
                                      padding: EdgeInsets.only(
                                          left:
                                              AppThemeData.varPaddingNormal * 2,
                                          right:
                                              AppThemeData.varPaddingNormal * 2,
                                          bottom:
                                              AppThemeData.varPaddingNormal *
                                                  2),
                                      child: TextField(
                                        controller: state.titleController,
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        maxLength: 30,
                                        enabled: state.type != Types.processing,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            //labelText: 'Password',
                                            hintText: "Name"),
                                      ))),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppThemeData.colorPrimary,
                                  //border: Border.
                                ),
                                //color: AppThemeData.colorPrimary,
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: AppThemeData.colorCard,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0),
                                    ),
                                    // this border is needed to fix an anti-aliasing error within flutter
                                    border: Border.all(
                                        width: 6.0, color: Colors.white),
                                  ),
                                  padding: EdgeInsets.all(
                                      AppThemeData.varPaddingNormal * 2),
                                  child: TextField(
                                    controller: state.aboutController,
                                    enabled: state.type != Types.processing,
                                    decoration: InputDecoration(
                                        //border: InputBorder.none, //OutlineInputBorder(),
                                        labelText: "Beschreibe deine Gruppe",
                                        alignLabelWithHint: true),
                                    minLines: 2,
                                    maxLines: 4,
                                  ),
                                  /*Text("Sichtbarkeit"),
                              ToggleButtons(
                                children: <Widget>[
                                  Text("Öffentlich"),
                                  Text("Privat"),
                                ],
                                onPressed: (int index) {
                                  /*setState(() {
                                isSelected[index] = !isSelected[index];
                              });*/
                                },
                                isSelected: [false, true],
                              ),*/
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.check,
                  color: AppThemeData.colorTextInverted,
                ),
                onPressed: () {
                  state.submit();
                },
              ));
        });
  }
}
