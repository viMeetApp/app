import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/cubit/create_post_cubit.dart';
import 'package:signup_app/util/presets.dart';

class CreatePostForm extends StatelessWidget {
  //Ich glaube das ist eine schöne Lösung um um alle Text Ediding Controller rumzukommen
  Map<String, dynamic> mandatoryFields = {
    'title': null,
    'about': null,
    'tags': ['outdoor']
  };

  Map<String, dynamic> optionalFields = {
    'treffpunkt': null,
    'kosten': null,
  };

  Map<String, dynamic> eventOnlyFields = {
    'maxPeople': -1,
  };

  Map<String, dynamic> buddyOnlyFields = {};
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
      body: BlocListener<CreatePostCubit, CreatePostState>(
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
        child: BlocBuilder<CreatePostCubit, CreatePostState>(
            builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  color: AppThemeData.colorPrimaryLight,
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      TextField(
                        onChanged: (text) {
                          mandatoryFields['title'] =
                              (text != null && text.length > 0) ? text : null;
                        },
                        decoration: Presets.getTextFieldDecorationHintStyle(
                            hintText: "Titel"),
                      ),
                      // TODO change this to a 'chip'-style input
                      new TextFormField(
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        decoration: Presets.getTextFieldDecorationHintStyle(
                            hintText: "Tags / Kategorien",
                            fillColor: AppThemeData.colorBlackTrans,
                            hintColor: AppThemeData.colorCard),
                      ),
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
                            new TextFormField(
                              onChanged: (text) {
                                mandatoryFields['about'] =
                                    (text != null && text.length > 0)
                                        ? text
                                        : null;
                              },
                              minLines: 3,
                              maxLines: null,
                              decoration:
                                  Presets.getTextFieldDecorationHintStyle(
                                      hintText: "Beschreibung:"),
                            ),
                            SizedBox(
                              height: 120,
                            ),
                            Text("Angaben da es sich um einen Post handelt"),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  tooltip: 'Tap to open date picker',
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
                                ),
                                Text(state.eventDate != null
                                    ? state.eventDate.toString()
                                    : "Datum des Events")
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.access_time),
                                  tooltip: 'Tap to open date picker',
                                  onPressed: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      BlocProvider.of<CreatePostCubit>(context)
                                          .updateTime(value);
                                    });
                                  },
                                ),
                                Text(state.eventTime != null
                                    ? state.eventTime.toString()
                                    : "Startzeit des Events")
                              ],
                            ),
                            new TextFormField(
                              onChanged: (text) {
                                eventOnlyFields['maxPeople'] =
                                    (text != null && text.length > 0)
                                        ? int.parse(text)
                                        : -1;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: Presets.getTextFieldDecorationLabelStyle(
                                  labelText:
                                      "max. Anzahl (leer lassen für unbegrenzt)"),
                            ),
                            SizedBox(
                              height: 90,
                            ),
                            Text("Weitere Freiwillige Angaben"),
                            new TextFormField(
                              onChanged: (text) {
                                optionalFields['treffpunkt'] =
                                    (text != null && text.length > 0)
                                        ? text
                                        : null;
                              },
                              decoration:
                                  Presets.getTextFieldDecorationLabelStyle(
                                      labelText: "Treffpunkt"),
                            ),
                            new TextFormField(
                              onChanged: (text) {
                                optionalFields['kosten'] =
                                    (text != null && text.length > 0)
                                        ? text
                                        : null;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration:
                                  Presets.getTextFieldDecorationLabelStyle(
                                      labelText: "Kosten"),
                            ),
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
          BlocProvider.of<CreatePostCubit>(context).submit(
              mandatoryFields: mandatoryFields,
              optionalFields: optionalFields,
              eventOnlyFields: eventOnlyFields);
        },
        child: Icon(
          Icons.send,
          color: AppThemeData.colorCard,
        ),
      ),
    );
  }
}
