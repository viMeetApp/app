import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/chat_message_repository.dart';
import 'package:signup_app/repositories/pagination/chat_message_pagination.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/models/data_models.dart';

class ChatCubit extends Cubit<Stream<List<Message>>> {
  final Post post;
  final User? user;

  final ChatMessageRepository _chatMessageRepository =
      new ChatMessageRepository();
  late ChatMessagePagination chatMessagePagination;

  ChatCubit({required this.post})
      : user = UserRepository().getUser(),
        super(Stream.empty()) {
    chatMessagePagination =
        new ChatMessagePagination(post: post, paginationDistance: 20);
    emit(chatMessagePagination.messageStreamController.stream);
    chatMessagePagination.requestMessages();
  }

  void sendMessage(String content) {
    //Check if MessageString is valid
    if (content.length != 0) {
      Message chatMessage =
          Message.createTextMessage(author: user, content: content);
      _chatMessageRepository.createChatMessage(
          post: post, message: chatMessage);
    }
  }
}
