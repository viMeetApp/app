import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/widgets/chat/view/message_tile.dart';
import 'package:signup_app/util/data_models.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/util/creation_aware_widget.dart';

import '../chat.dart';

class ChatWidget extends StatelessWidget {
  final Post post;
  final Function? onTap;

  final TextEditingController _chatController = new TextEditingController();
  ChatWidget({required this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => ChatCubit(post: post),
        child: BlocBuilder<ChatCubit, Stream<List<Message>>>(
          builder: (context, state) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                      stream: state,
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Expanded(
                              child: Center(child: Text("unknown Error")));
                        else if (!snapshot.hasData)
                          //Return Nothing
                          return Expanded(child: Container());
                        else {
                          var blocRef = BlocProvider.of<ChatCubit>(context);
                          return Expanded(
                            child: ListView.builder(
                                reverse: true,
                                itemCount: (snapshot.data as List).length,
                                itemBuilder: (context, index) =>
                                    CreationAwareWidget(
                                      itemCreated: () {
                                        if ((index + 1) %
                                                blocRef.chatMessagePagination
                                                    .paginationDistance ==
                                            0) {
                                          blocRef.chatMessagePagination
                                              .requestMessages();
                                        }
                                      },
                                      child: MessageTile(
                                          message:
                                              (snapshot.data as List)[index]),
                                    )),
                          );
                        }
                      },
                    ),
                    Align(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 8),
                          child: Row(
                            children: [
                              Flexible(
                                  child: TextFormField(
                                onTap: () {
                                  onTap!();
                                }, //Schließt die Karte für Details -> geht nur wenn Chat immer in diesem Context verwendet wird
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 4,
                                controller: _chatController,
                                decoration: InputDecoration(
                                  hintText: "Nahricht...",
                                  fillColor: AppThemeData.colorCard,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    gapPadding: 1,
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        style: BorderStyle.none, width: 0),
                                  ),
                                ),
                              )),
                              IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: AppThemeData.colorControls,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ChatCubit>(context)
                                        .sendMessage(_chatController.text);
                                    _chatController.text = "";
                                  }),
                            ],
                          ),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
