import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signup_app/create_post/cubit/create_post_cubit.dart';
import 'package:signup_app/create_post/tags/cubit/tag_cubit.dart';
import 'package:signup_app/create_post/tags/view/tag-widget.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/dialog_helper.dart';
import 'package:signup_app/util/presets.dart';

import '../../util/presets.dart';

///Form from which posts are created. There are a few madatory Fields  title, about and tags, optional fields treffpunkt and kosten
///event only Fields max People
///buddy only Fields Event Date and Event Time are also optional
class CreatePostForm extends StatelessWidget {
  CreatePostForm();
/*
  Future _showDialog(
      {@required context,
      @required Widget child,
      @required String title,
      @required Function onOkay}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0.0,
          backgroundColor: AppThemeData.colorBase,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Wrap(
              children: [
                Text(
                  title,
                  style: AppThemeData.textHeading3(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  child: child,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        onPressed: () => {Navigator.pop(context, null)},
                        child: Text("Abbrechen")),
                    FlatButton(onPressed: onOkay, child: Text("Ok"))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future _showTextInputDialog(
      {@required context,
      String title = "",
      String currentValue = "",
      List<TextInputFormatter> formatters,
      TextInputType keyboardType = TextInputType.text}) {
    Function onOkay = () {
      print(currentValue);
      Navigator.pop(context, currentValue);
    };

    return _showDialog(
        context: context,
        title: title,
        child: Wrap(
          children: [
            TextFormField(
              autofocus: true,
              initialValue: currentValue,
              onChanged: (text) {
                currentValue = text;
              },
              keyboardType: keyboardType,
              inputFormatters: formatters,
              decoration: Presets.getTextFieldDecorationHintStyle(),
            ),
          ],
        ),
        onOkay: onOkay);
  }
*/
  Widget _optionalField({
    @required context,
    Function onPressed,
    String text,
    IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: FlatButton.icon(
        textColor: AppThemeData.colorFormField,
        onPressed: onPressed,
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppThemeData.colorCard),
        backgroundColor: AppThemeData.colorPrimaryLight,
        title: Text(
          "Neuen Post erstellen",
          style: TextStyle(color: AppThemeData.colorTextInverted),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreatePostCubit, CreatePostState>(
            listener: (context, state) {
              //When Logged In -> Call Authetication Bloc with Logged in
              if (state.isSubmitted) {
                // !TODO navigate to the next screen
                Navigator.of(context).pop();
              }
              //In Error Case or name invalid Show Error Snackbar
              else if (state.isError) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text('Bitte alle Felder ausfüllen'),
                  ));
                BlocProvider.of<CreatePostCubit>(context).resetError();
              }
              //Show is Loading Snackbar
              else if (state.isSubmitting) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text('wird veröffentlicht'),
                  ));
              }
            },
          ),
          BlocListener<TagCubit, TagState>(listener: (context, state) {
            List<String> tagList = [];
            state.tagMap.forEach(
              (key, value) {
                if (value == true) tagList.add(key);
              },
            );
            BlocProvider.of<CreatePostCubit>(context)
                .setMandatoryField('tags', tagList);
          })
        ],
        child: BlocBuilder<CreatePostCubit, CreatePostState>(
            builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  color: AppThemeData.colorPrimaryLight,
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          onChanged: (text) {
                            BlocProvider.of<CreatePostCubit>(context)
                                .setMandatoryField(
                                    'title',
                                    (text != null && text.length > 0)
                                        ? text
                                        : null);
                          },
                          decoration: Presets.getTextFieldDecorationHintStyle(
                              hintText: "Titel"),
                        ),
                      ),
                      TagWidget(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
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
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025),
                                  ).then((value) {
                                    BlocProvider.of<CreatePostCubit>(context)
                                        .updateDate(value);
                                  });
                                },
                                icon: Icon(Icons.calendar_today),
                                label: Expanded(
                                  child: Text(
                                      state.eventDate != null
                                          ? DateFormat('dd.MM.yyyy')
                                              .format(state.eventDate)
                                          : "Datum",
                                      style: AppThemeData.textFormField()),
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
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    BlocProvider.of<CreatePostCubit>(context)
                                        .updateTime(value);
                                  });
                                },
                                icon: Icon(Icons.access_time),
                                label: Expanded(
                                  child: Text(
                                    state.eventTime != null
                                        ? state.eventTime.format(context)
                                        : "Startzeit",
                                    style: AppThemeData.textFormField(),
                                  ),
                                ),
                              ),
                            ),
                            new TextFormField(
                              onChanged: (text) {
                                BlocProvider.of<CreatePostCubit>(context)
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
                                      hintText: "Beschreibung:"),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            /*Text("Weitere Freiwillige Angaben"),*/
                            new TextFormField(
                              onChanged: (text) {
                                BlocProvider.of<CreatePostCubit>(context)
                                    .setOptionalField(
                                        'treffpunkt',
                                        (text != null && text.length > 0)
                                            ? text
                                            : null);
                              },
                              decoration:
                                  Presets.getTextFieldDecorationLabelStyle(
                                      labelText: "Treffpunkt"),
                            ),
                            Container(
                              child: Theme(
                                data: ThemeData(
                                    dividerColor: Colors.transparent,
                                    accentColor: AppThemeData.colorPrimary),
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
                                        text:
                                            state.eventOnlyFields["maxPeople"] <
                                                    0
                                                ? "Teilnehmer unbegrenzt"
                                                : "maximal " +
                                                    state.eventOnlyFields[
                                                            "maxPeople"]
                                                        .toString() +
                                                    " Teilnehmer",
                                        onPressed: () => {
                                          DialogHelper.showTextInputDialog(
                                              title: "Maximale Zeilnehmerzahl",
                                              context: context,
                                              keyboardType:
                                                  TextInputType.number,
                                              formatters: [
                                                WhitelistingTextInputFormatter
                                                    .digitsOnly
                                              ]).then((value) {
                                            BlocProvider.of<CreatePostCubit>(
                                                    context)
                                                .setEventOnlyField(
                                                    'maxPeople',
                                                    (value != null &&
                                                            value.length > 0)
                                                        ? int.parse(value)
                                                        : -1);
                                          })
                                        },
                                      ),
                                      _optionalField(
                                        context: context,
                                        icon: Icons.euro_symbol,
                                        text: state.optionalFields["kosten"] ==
                                                    null ||
                                                state.optionalFields["kosten"]
                                                        .length <
                                                    1
                                            ? "keine Kosten festgelegt"
                                            : state.optionalFields["kosten"]
                                                .toString(),
                                        onPressed: () {
                                          DialogHelper.showTextInputDialog(
                                              title: "Kosten pro Person",
                                              context: context,
                                              formatters: []).then((value) {
                                            print(value);
                                            BlocProvider.of<CreatePostCubit>(
                                                    context)
                                                .setOptionalField(
                                                    'kosten',
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
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("submit pressed");
          BlocProvider.of<CreatePostCubit>(context).submit();
        },
        child: Icon(
          Icons.send,
          color: AppThemeData.colorCard,
        ),
      ),
    );
  }
}
