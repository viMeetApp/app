import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/util/widgets/vi_dialog.dart';
import 'package:signup_app/widgets/post_editor/event_editor/cubit/event_editor_cubit.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/cubit/tag_cubit.dart';
import 'package:signup_app/widgets/post_editor/widgets/tags/view/tag-widget.dart';

class EventEditorForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventEditorCubit _eventEditorCubit =
        BlocProvider.of<EventEditorCubit>(context);
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
          BlocListener<EventEditorCubit, EventEditorState>(
            listener: (context, state) {
              //ToDo show succes page
              if (state.validationState.wasSubmitted) {
                Navigator.of(context).pop();
              } else if (state.validationState.isError) {
                Tools.showSnackbar(context, 'Could not upload post');
              } else if (state.validationState.isSubmitting) {
                Tools.showSnackbar(context, 'wird veröffentlicht');
              }
            },
          ),
          BlocListener<TagCubit, TagState>(
            listener: (context, state) {
              // ToDo to update tags with enums
              List<PostTag> tags = [];
              state.tagMap.forEach((key, value) {
                {
                  if (value == true) tags.add(key);
                }
              });
              _eventEditorCubit.setTags(tags);
            },
          )
        ],
        child: BlocBuilder<EventEditorCubit, EventEditorState>(
            builder: (context, state) {
          print(state.eventAt);
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

                              //---------------------------------------------
                              //Title Text Field
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                                maxLines: 4,
                                minLines: 2,
                                maxLength: 90,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    //labelText: 'Password',
                                    hintText: "Titel"),
                                initialValue: state.title,
                                onChanged: (text) {
                                  _eventEditorCubit.setTitle(text);
                                },
                              ),
                            ),

                            //---------------------------------------------
                            //Tag Widget
                            if (state.groupReference != null)
                              groupInfoField(state.groupReference!),

                            //---------------------------------------------
                            //Tag Widget
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
                                  //---------------------------------
                                  DateAndTimePicker(
                                    dateInMilliseconds: state.eventAt,
                                  ),
                                  //----------------------------------
                                  TextFormField(
                                    initialValue: state.about,
                                    onChanged: (text) {
                                      _eventEditorCubit.setAbout(text);
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
                                  //---------------------------------------
                                  new TextFormField(
                                    initialValue: state.eventLocation,
                                    onChanged: (text) {
                                      _eventEditorCubit.setEventLocation(text);
                                    },
                                    decoration: Presets
                                        .getTextFieldDecorationLabelStyle(
                                            labelText: "Treffpunkt"),
                                  ),

                                  //-----------------------------------------
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
                                              text: state.maxParticipants < 0
                                                  ? "Teilnehmende unbegrenzt"
                                                  : "maximal " +
                                                      state.maxParticipants
                                                          .toString() +
                                                      " Teilnehmende",
                                              onPressed: () => {
                                                ViDialog.showTextInputDialog(
                                                    title:
                                                        "Maximale Teilnehmer*innen-zahl",
                                                    context: context,
                                                    keyboardType: TextInputType.number,
                                                    formatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ]).then(
                                                  (value) {
                                                    _eventEditorCubit
                                                        .setMaxParticipants(
                                                            (value != null &&
                                                                    value.length >
                                                                        0)
                                                                ? int.parse(
                                                                    value)
                                                                : -1);
                                                  },
                                                )
                                              },
                                            ),
                                            _optionalField(
                                              context: context,
                                              icon: Icons.euro_symbol,
                                              text: state.costs != null
                                                  ? state.costs.toString()
                                                  : "keine Kosten festgelegt",
                                              onPressed: () {
                                                ViDialog
                                                    .showTextInputDialog(
                                                        title:
                                                            "Kosten pro Person",
                                                        context: context,
                                                        formatters: []).then(
                                                    (value) {
                                                  _eventEditorCubit.setCosts(
                                                      (value != null &&
                                                              value.length > 0)
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
          _eventEditorCubit.submit();
        },
        child: Icon(
          Icons.send,
          color: AppThemeData.colorCard,
        ),
      ),
    );
  }
}

class DateAndTimePicker extends StatelessWidget {
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  DateAndTimePicker({int? dateInMilliseconds}) {
    _dateTime = dateInMilliseconds != null
        ? DateTime.fromMillisecondsSinceEpoch(dateInMilliseconds)
        : null;
    _timeOfDay = _dateTime != null ? TimeOfDay.fromDateTime(_dateTime!) : null;
  }

  void updateEventTime(BuildContext context) {
    if (_dateTime == null)
      return BlocProvider.of<EventEditorCubit>(context).setEventAt(null);
    else {
      DateTime tempDate =
          new DateTime(_dateTime!.year, _dateTime!.month, _dateTime!.day);
      if (_timeOfDay != null)
        tempDate = new DateTime(tempDate.year, tempDate.month, tempDate.day,
            _timeOfDay!.hour, _timeOfDay!.minute);
      else {
        final currentTime = TimeOfDay.now();
        tempDate = new DateTime(tempDate.year, tempDate.month, tempDate.day,
            currentTime.hour, currentTime.minute);
      }
      BlocProvider.of<EventEditorCubit>(context)
          .setEventAt(tempDate.millisecondsSinceEpoch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextButton.icon(
            //textColor: AppThemeData.colorFormField,
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: _dateTime ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025),
              ).then((DateTime? date) {
                _dateTime = date;
                updateEventTime(context);
              });
            },
            icon: Icon(Icons.calendar_today),
            label: Expanded(
              child: Text(
                  _dateTime != null
                      ? Tools.readableDateFromDate(_dateTime!)
                      : "Datum",
                  style: AppThemeData.textFormField()),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton.icon(
            // textColor: AppThemeData.colorFormField,
            // This Button is only active if an date is set -> can not set time without a date
            onPressed: _dateTime != null
                ? () {
                    showTimePicker(
                            context: context,
                            initialTime: _timeOfDay ??
                                TimeOfDay
                                    .now()) //Normaly TimeOfDay.now() should never be called because only active if DateTime is set
                        .then((TimeOfDay? time) {
                      _timeOfDay = time;
                      updateEventTime(context);
                    });
                  }
                : null,
            icon: Icon(Icons.access_time),
            label: Expanded(
              child: Text(
                _timeOfDay != null
                    ? Tools.readableTimeFromTimeOfDay(_timeOfDay!)
                    : "Startzeit",
                style: AppThemeData.textFormField(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _optionalField({
  required context,
  Function? onPressed,
  required String text,
  IconData? icon,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 6, bottom: 6),
    child: TextButton.icon(
      //textColor: AppThemeData.colorFormField,
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

Widget groupInfoField(GroupReference group) {
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
        Text(group.name, style: AppThemeData.textHeading4(color: Colors.white))
      ]));
}
/*class EditorTextField extends StatelessWidget {
  void Function() callback;
  final String hintText;
  final String content
  EditorTextField({this.hintText= "", required String content, required this.callback}) {
    textController.text = content;
  }

  @override
  Widget build(BuildContext context){
    TextFormField(
      initialValue: ,
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
  }
}
*/
