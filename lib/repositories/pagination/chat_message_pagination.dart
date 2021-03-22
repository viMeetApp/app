import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/data_models.dart';

class ChatMessagePagination {
  final paginationDistance;
  final Post post;

  ChatMessagePagination({required this.post, this.paginationDistance: 20});

  StreamController<List<Message>> messageStreamController =
      new StreamController<List<Message>>();

  //Variables necessary for Pagination
  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  List<List<Message>> _allPagedResults = [];
  void requestMessages() {
    //If there are no more posts return
    if (!_hasMorePosts) return;

    Query chatMessageQuery = FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(paginationDistance);

    //If last Document is specified, we need to start Pagination after last Document
    if (_lastDocument != null) {
      chatMessageQuery = chatMessageQuery.startAfterDocument(_lastDocument!);
    }

    //Index is number of times we already paginated
    int currentRequestIndex = _allPagedResults.length;

    //Callback Function called every Time there is an updated
    chatMessageQuery
        .snapshots()
        .listen((QuerySnapshot chatMessageListSnapshot) {
      if (chatMessageListSnapshot.docs.isNotEmpty) {
        List<Message> chatMessages = chatMessageListSnapshot.docs
            .map((QueryDocumentSnapshot chatMessageDoc) =>
                Message.fromDoc(chatMessageDoc))
            .toList();

        //Check if page already exists then only updated, otherwise new Query add Documents
        bool pageExists = currentRequestIndex < _allPagedResults.length;

        //If page exists only update the elements
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = chatMessages;
        }
        //Otherwise create new Page
        else {
          _allPagedResults.add(chatMessages);
        }

        //Concaternate the pages to one big List of Messages
        List<Message> allChatMessages = _allPagedResults.fold<List<Message>>(
            [], (initialValue, pageItems) => initialValue..addAll(pageItems));

        //Broadcast this updated List Via Stream
        messageStreamController.add(allChatMessages);

        //Save the last document from result -> for next Pagination step (only if callback is triggered on last Page)
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = chatMessageListSnapshot.docs.last;
        }

        //Dertermine if there are more posts to request
        _hasMorePosts = chatMessages.length == paginationDistance;
      }
    });
  }
}
