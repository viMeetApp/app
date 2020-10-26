import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/create_post/cubit/create_post_cubit.dart';
import 'package:signup_app/util/presets.dart';

class CreatePostForm extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: (context, state) {
        //When Logged In -> Call Authetication Bloc with Logged in
        if (state.isSubmitted) {
          // !TODO navigate to the next screen
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
          buildWhen: (previous, current) => previous.isError != current.isError,
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: AppThemeData.colorCard),
                backgroundColor: AppThemeData.colorPrimaryLight,
                title: Text(
                  "Neuen Post erstellen",
                  style: TextStyle(color: AppThemeData.colorTextInverted),
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: AppThemeData.colorPrimaryLight,
                      child: Wrap(
                        runSpacing: 10,
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: Presets.getTextFieldDecoration(
                                hintText: "Titel"),
                          ),
                          // TODO change this to a 'chip'-style input
                          new TextFormField(
                            maxLines: null,
                            style: TextStyle(color: Colors.white),
                            decoration: Presets.getTextFieldDecoration(
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
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "TODO: DateSelector")));
                                      },
                                    ),
                                    Text("Datum des Events")
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.access_time),
                                      tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "TODO: TimeSelector")));
                                      },
                                    ),
                                    Text("Startzeit des Events")
                                  ],
                                ),
                                new TextFormField(
                                  decoration: Presets.getTextFieldDecoration(
                                      hintText: "Treffpunkt"),
                                ),
                                new TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: Presets.getTextFieldDecoration(
                                      hintText: "Kosten"),
                                ),
                                new TextFormField(
                                  minLines: 3,
                                  maxLines: null,
                                  decoration: Presets.getTextFieldDecoration(
                                      hintText: "Text"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => {},
                child: Icon(
                  Icons.send,
                  color: AppThemeData.colorCard,
                ),
              ),
            );
          }),
    );
  }
}
