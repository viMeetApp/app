import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:signup_app/repositories/chat_message_repository.dart';
import 'package:signup_app/repositories/pagination/chat_message_pagination.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/common.dart';

class ChatCubit extends Cubit<Stream<List<Message>>> {
  final Post post;
  late final User user;

  final ChatMessageRepository _chatMessageRepository;
  final AuthenticationService _authService;
  late ChatMessagePagination chatMessagePagination;

  ChatCubit(
      {required this.post,
      ChatMessageRepository? chatMessageRepository,
      AuthenticationService? authenticationService,
      ChatMessagePagination? chatMessagePagination})
      : _chatMessageRepository =
            chatMessageRepository ?? ChatMessageRepository(),
        _authService = authenticationService ?? AuthenticationService(),
        super(Stream.empty()) {
    user = _authService.getCurrentUser();
    this.chatMessagePagination = chatMessagePagination ??
        new ChatMessagePagination(post: post, paginationDistance: 20);
    emit(this.chatMessagePagination.messageStreamController.stream);
    this.chatMessagePagination.requestMessages();
  }

  void sendMessage(String content) {
    //Check if MessageString is valid
    if (content.length != 0) {
      Message chatMessage = Message(
          author: user,
          type: MessageType.text,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          content: content);
      _chatMessageRepository.createChatMessage(
          post: post, message: chatMessage);
    }
  }
}
