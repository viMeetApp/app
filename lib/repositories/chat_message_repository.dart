import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/util/models/data_models.dart';

class ChatMessageRepository {
  final FirebaseFirestore _firestore;
  late CollectionReference _postCollectionReference;

  ChatMessageRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _postCollectionReference = _firestore.collection('posts');
  }

  ///Create c chat Message from [message] in [post]
  Future<void> createChatMessage(
      {required Post post, required Message message}) async {
    try {
      if (message.content!.length != 0) {
        await _postCollectionReference
            .doc(post.id)
            .collection('messages')
            .add(message.toMap());
      }
    } catch (err) {
      throw err;
    }
  }
}
