import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/data_models.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostState.empty());

  /// Document gets submitted
  /// !TODO Checks if all fields are filled out
  void submitted() async {
    emit(CreatePostState.loading());

    // !TODO implement the submitting of posts
  }

  void sendMessage(String content) {
    //Check If String is Valid For Example don't send Empty String
    /*if (content.length != 0 ?? content != null) {
      Post message =
          Message.createTextMessage(author: user, content: content);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('messages')
          .add(message.toJson());
    }*/
  }

  void submit(
      {Map<String, dynamic> mandatoryFields,
      Map<String, dynamic> optionalFields}) async {
    bool abort = false;
    //First Check if all mandatory Field aren't empty
    mandatoryFields.forEach((key, value) {
      if (value == null) {
        print("mandatory Field empty");
        abort = true;
        emit(CreatePostState.error());
      }
    });
    if (abort) {
      print("abort");
      return;
    }
    //bring optional Fields in Array Structure
    List<PostDetail> postDetails = [];
    //First Add Time if existent
    //Add Time to optional Fields
    if (state.eventDate != null) {
      postDetails.add(PostDetail(
          id: 'eventDate',
          value: state.eventDate.millisecondsSinceEpoch.toString()));
    }
    if (state.eventTime != null) {
      postDetails.add(PostDetail(
          id: 'eventTime',
          value: '${state.eventTime.hour}/${state.eventTime.minute}'));
    }
    //Then add other Fields
    optionalFields.forEach((key, value) {
      if (value != null) {
        postDetails.add(PostDetail(id: key, value: value));
      }
    });

    //Create Post
    //!Todo Schauen ob Event oder Buddy und schauen ob mit Gruppe oder nicht
    Event event = Event()
      ..title = mandatoryFields['title']
      ..geohash = "ToDoHash"
      ..tags = [...mandatoryFields['tags'], 'event']
      ..about = mandatoryFields['about']
      ..type = "event"
      ..createdDate = DateTime.now().millisecondsSinceEpoch
      ..expireDate = DateTime.now().millisecondsSinceEpoch
      ..details = postDetails
      ..eventDate = DateTime.now().millisecondsSinceEpoch
      ..participants = [fire.FirebaseAuth.instance.currentUser.uid]
      ..maxPeople = 10
      ..author = await UserRepository().getUser();
    //Write to Firetore
    await FirebaseFirestore.instance.collection('posts').add(event.toJson());
    emit(CreatePostState.success());
  }

  void updateDate(DateTime eventDate) {
    emit(state.copyWith(eventDate: eventDate, eventTime: state.eventTime));
  }

  void updateTime(TimeOfDay eventTime) {
    emit(state.copyWith(eventTime: eventTime, eventDate: state.eventDate));
  }
}
