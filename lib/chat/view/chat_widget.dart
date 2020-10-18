import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/chat/view/message_tile.dart';
import 'package:signup_app/util/DataModels.dart';

import '../chat.dart';

class ChatWidget extends StatelessWidget {
  String postId;
  User user;

  TextEditingController _chatController=new TextEditingController();
  ChatWidget({@required this.postId, @required this.user}): assert(postId!=null), assert(user!=null);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) => ChatCubit(postId: postId, user: user),
        child: BlocBuilder<ChatCubit, Stream<List<Message>>>(
          builder: (context, state) {
            return Expanded(
                          child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder(
                      stream: state,
                      builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Expanded(child: Center(child: CircularProgressIndicator()));
              else {
                debugPrint(snapshot.data.length.toString());
                return Expanded(
                                  child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) =>
                        MessageTile(message: snapshot.data[index])),
                );
              }
                      },
                    ),
                    Align(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 4,
                    controller: _chatController,
                    decoration: InputDecoration(
                        hintText: "Nahricht...",
                        fillColor: Colors.red,
                        focusColor: Colors.red),
                  )),
                  IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        BlocProvider.of<ChatCubit>(context)
                            .sendMessage(_chatController.text);
                        _chatController.text="";
                      }),
                ],
              ),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                    )
                  ],
                ),
            );
          },
        ),
      ),
    );
  }
}