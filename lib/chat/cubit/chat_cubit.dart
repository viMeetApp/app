import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/util/DataModels.dart';



class ChatCubit extends Cubit<Stream<List<Message>>> {
  final String postId;
  final User user;
  Stream<List<Message>> messageStream;
  ChatCubit({@required this.postId, @required this.user}) :assert(postId!=null),assert(user!=null), super(Stream.empty()){

    //I don't think we need an extra reopsitory maybe later when also images
    Stream<List<Message>> messageStream=FirebaseFirestore.instance.collection('posts').doc(postId).collection('messages').orderBy('timestamp',descending: true).limit(20).snapshots().map((list)=>list.docs.map((doc){
      return Message.fromJson(doc.data());}).toList());
    print(messageStream);
    emit(messageStream);
  }

  void sendMessage(String content){
    //Check If String is Valid For Example don't send Empty String
    if(content.length!=0??content!=null){
    Message message = Message.createTextMessage(author: user, content: content);
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('messages').add(message.toJson());
    }
  }
}
