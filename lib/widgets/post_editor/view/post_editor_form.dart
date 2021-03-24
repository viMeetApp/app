import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signup_app/util/widgets/vi_dialog.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/post_editor/cubit/post_editor_cubit.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/cubit/tag_cubit.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/view/tag-widget.dart';

import '../../../util/presets.dart';

///Form from which posts are created. There are a few madatory Fields  title, about and tags, optional fields treffpunkt and kosten
///event only Fields max People
///buddy only Fields Event Date and Event Time are also optional
class CreatePostForm extends StatelessWidget {
  CreatePostForm();

  Widget groupInfoField(PostEditorState state) {
    return Container(
        padding: EdgeInsets.only(left: 13, right: 10, top: 5),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.group,
              color: Colors.white,
            ),
          ),
          Text(state.group!.name!,
              style: AppThemeData.textHeading4(color: Colors.white))
        ]));
  }

  Widget _optionalField({
    required context,
    Function? onPressed,
    required String text,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: FlatButton.icon(
        textColor: AppThemeData.colorFormField,
        onPressed: onPressed as void Function()?,
        icon: Icon(icon),
        label: Expanded(
          child: Text(
            text,
            style: AppThemeData.textFormField(color: null),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.colorBase,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: AppThemeData.colorCard),
        backgroundColor: AppThemeData.colorPrimaryLight,
        title: Text(
          "Neuen Post erstellen",
          style: TextStyle(color: AppThemeData.colorTextInverted),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PostEditorCubit, PostEditorState>(
            listener: (context, state) {
              print("setState isError: " + state.isError.toString());
              //When Logged In -> Call Authetication Bloc with Logged in
              if (state.isSubmitted) {
                Navigator.of(context).pop();
              }
              //In Error Case or name invalid Show Error Snackbar
              else if (state.isError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text('Fehler: ' + state.error.toString()),
                  ));
                /*ViDialog.showWidgetDialog(
                    context: context,
                    child: Text(state.error.toString()),
                    title: "Fehler",
                    noActions: true,
                    onOkay: () {});
                BlocProvider.of<PostEditorCubit>(context).resetError();*/
              }
              //Show is Loading Snackbar
              else if (state.isSubmitting) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text('wird veröffentlicht'),
                  ));
              }
            },
          ),
          BlocListener<TagCubit, TagState>(listener: (context, state) {
            List<String?> tagList = [];
            state.tagMap.forEach(
              (key, value) {
                if (value == true) tagList.add(key);
              },
            );
            BlocProvider.of<PostEditorCubit>(context)
                .setMandatoryField('tags', tagList);
          })
        ],
        child: BlocBuilder<PostEditorCubit, PostEditorState>(
            builder: (context, state) {
          //TODO Temporärer Fix damit die Curser-Position nicht konstant an den Anfang des Feldes springt
          TextEditingController titleController =
              TextEditingController(text: state.mandatoryFields['title']);
          titleController.selection = TextSelection.fromPosition(
              TextPosition(offset: titleController.text.length));

          TextEditingController aboutController =
              TextEditingController(text: state.mandatoryFields['about']);
          aboutController.selection = TextSelection.fromPosition(
              TextPosition(offset: aboutController.text.length));

          TextEditingController placeController =
              TextEditingController(text: state.optionalFields['treffpunkt']);
          placeController.selection = TextSelection.fromPosition(
              TextPosition(offset: placeController.text.length));

          return SafeArea(
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData.dark(),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppThemeData.colorPrimaryLight,
                          border: Border(
                              top: BorderSide(
                                  width: 5.0,
                                  color: AppThemeData.colorPrimaryLight)),
                        ),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: AppThemeData.varPaddingNormal * 2,
                                  right: AppThemeData.varPaddingNormal * 2,
                                  bottom: AppThemeData.varPaddingNormal * 2),

                              //padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                                maxLines: 4,
                                minLines: 2,
                                maxLength: 90,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    //labelText: 'Password',
                                    hintText: "Titel"),
                                controller: titleController,
                                onChanged: (text) {
                                  print("submitted");
                                  BlocProvider.of<PostEditorCubit>(context)
                                      .setMandatoryField(
                                          'title',
                                          (text != null && text.length > 0)
                                              ? text
                                              : null);
                                },
                              ),
                            ),
                            if (state.group != null) groupInfoField(state),
                            TagWidget(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: AppThemeData.colorPrimaryLight,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: AppThemeData.colorBase,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          ),
                          // this border is needed to fix an anti-aliasing error within flutter
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Wrap(
                                runSpacing: 10,
                                children: [
                                  FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: FlatButton.icon(
                                      textColor: AppThemeData.colorFormField,
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate:
                                              state.eventDate ?? DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2025),
                                        ).then((value) {
                                          BlocProvider.of<PostEditorCubit>(
                                                  context)
                                              .updateDate(value);
                                        });
                                      },
                                      icon: Icon(Icons.calendar_today),
                                      label: Expanded(
                                        child: Text(
                                            state.eventDate != null
                                                ? DateFormat('dd.MM.yyyy')
                                                    .format(state.eventDate!)
                                                : "Datum",
                                            style:
                                                AppThemeData.textFormField()),
                                      ),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: FlatButton.icon(
                                      textColor: AppThemeData.colorFormField,
                                      onPressed: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: state.eventTime ??
                                                    TimeOfDay.now())
                                            .then((value) {
                                          BlocProvider.of<PostEditorCubit>(
                                                  context)
                                              .updateTime(value);
                                        });
                                      },
                                      icon: Icon(Icons.access_time),
                                      label: Expanded(
                                        child: Text(
                                          state.eventTime != null
                                              ? state.eventTime!.format(context)
                                              : "Startzeit",
                                          style: AppThemeData.textFormField(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  new TextFormField(
                                    controller:
                                        aboutController, //TextEditingController(text: state.mandatoryFields['about']),
                                    onChanged: (text) {
                                      BlocProvider.of<PostEditorCubit>(context)
                                          .setMandatoryField(
                                              'about',
                                              (text != null && text.length > 0)
                                                  ? text
                                                  : null);
                                    },
                                    minLines: 3,
                                    maxLines: null,
                                    decoration:
                                        Presets.getTextFieldDecorationHintStyle(
                                            hintText: "weitere Infos:"),
                                  ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                  /*Text("Weitere Freiwillige Angaben"),*/
                                  new TextFormField(
                                    controller:
                                        placeController, //TextEditingController(text: state.optionalFields['treffpunkt']),
                                    onChanged: (text) {
                                      BlocProvider.of<PostEditorCubit>(context)
                                          .setOptionalField(
                                              'treffpunkt',
                                              (text != null && text.length > 0)
                                                  ? text
                                                  : null);
                                    },
                                    decoration: Presets
                                        .getTextFieldDecorationLabelStyle(
                                            labelText: "Treffpunkt"),
                                  ),
                                  Container(
                                    child: Theme(
                                      data: ThemeData(
                                          dividerColor: Colors.transparent,
                                          accentColor:
                                              AppThemeData.colorPrimary),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            AppThemeData.varCardRadius),
                                        child: ExpansionTile(
                                          backgroundColor: Colors.white,
                                          title: Text("optionale Angaben"),
                                          children: [
                                            _optionalField(
                                              context: context,
                                              icon: Icons.group,
                                              text: state.eventOnlyFields[
                                                          "maxPeople"] <
                                                      0
                                                  ? "Teilnehmer unbegrenzt"
                                                  : "maximal " +
                                                      state.eventOnlyFields[
                                                              "maxPeople"]
                                                          .toString() +
                                                      " Teilnehmer",
                                              onPressed: () => {
                                                ViDialog.showTextInputDialog(
                                                    title:
                                                        "Maximale Zeilnehmerzahl",
                                                    context: context,
                                                    keyboardType: TextInputType.number,
                                                    formatters: [
                                                      WhitelistingTextInputFormatter
                                                          .digitsOnly
                                                    ]).then((value) {
                                                  BlocProvider.of<
                                                              PostEditorCubit>(
                                                          context)
                                                      .setEventOnlyField(
                                                          'maxPeople',
                                                          (value != null &&
                                                                  value.length >
                                                                      0)
                                                              ? int.parse(value)
                                                              : -1);
                                                })
                                              },
                                            ),
                                            _optionalField(
                                              context: context,
                                              icon: Icons.euro_symbol,
                                              text: state.optionalFields[
                                                              "kosten"] ==
                                                          null ||
                                                      state
                                                              .optionalFields[
                                                                  "kosten"]
                                                              .length <
                                                          1
                                                  ? "keine Kosten festgelegt"
                                                  : state
                                                      .optionalFields["kosten"]
                                                      .toString(),
                                              onPressed: () {
                                                ViDialog
                                                    .showTextInputDialog(
                                                        title:
                                                            "Kosten pro Person",
                                                        context: context,
                                                        formatters: []).then(
                                                    (value) {
                                                  BlocProvider.of<
                                                              PostEditorCubit>(
                                                          context)
                                                      .setOptionalField(
                                                          'kosten',
                                                          (value != null &&
                                                                  value.length >
                                                                      0)
                                                              ? value
                                                              : null);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("submit pressed");
          BlocProvider.of<PostEditorCubit>(context).submit();
        },
        child: Icon(
          Icons.send,
          color: AppThemeData.colorCard,
        ),
      ),
    );
  }
}
