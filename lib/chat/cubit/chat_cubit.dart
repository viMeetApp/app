import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/util/data_models.dart';

class ChatCubit extends Cubit<Stream<List<Message>>> {
  final String postId;
  final User user;

  StreamController<List<Message>> _messageStreamController =
      new StreamController<List<Message>>();
  Stream<List<Message>> messageStream;
  ChatCubit({@required this.postId, @required this.user})
      : assert(postId != null),
        assert(user != null),
        super(Stream.empty()) {
    messageStream = _messageStreamController.stream;
    emit(messageStream);
    requestPosts();
  }

  void sendMessage(String content) {
    //Check If String is Valid For Example don't send Empty String
    if (content.length != 0 ?? content != null) {
      Message message =
          Message.createTextMessage(author: user, content: content);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('messages')
          .add(message.toDoc());
    }
  }

  DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;
  List<List<Message>> _allPagedResults = List<List<Message>>();
  //How many Items get paginated every time
  final paginationDistance = 20;

  ///Call if new Post needed (used for first time call and Pagination)
  void requestPosts() {
    //If there are no mor posts return
    if (!_hasMorePosts) return;

    Query pagePostQuery = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(paginationDistance);

    //If there is a last Document we paginate therefore gettin data after last Document
    if (_lastDocument != null) {
      pagePostQuery = pagePostQuery.startAfterDocument(_lastDocument);
    }

    //Index how often we already fetched new data -> Number of Lists in big List
    int currentRequestIndex = _allPagedResults.length;

    //Function is called every Time a Document updates itself
    pagePostQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        List<Message> posts = postsSnapshot.docs
            .map((snapshot) => Message.fromDoc(snapshot))
            .toList();

        //Check if page exists or is new page (hier könnte es etwas verwirrend sein, da man ja currenRequestIndex oben setzt)
        //Die Sache ist aber, dass das hier dirennen ja eine Callaback Funktion ist. Das heißt zeug kann sich hier auch ändern
        bool pageExists = currentRequestIndex < _allPagedResults.length;

        //If the page exists update the posts for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = posts;
        }
        //If Page doesn't exist add New Page
        else {
          _allPagedResults.add(posts);
        }

        //Concaternate the full list to be shown
        //Was hier passiert ist, dass die ganzen Sublisten jetzt in eine Zusammengepackt werden
        List<Message> allPosts = _allPagedResults.fold<List<Message>>(
            List<Message>(),
            (initialValue, pageItems) => initialValue..addAll(pageItems));

        //Broadcast all posts
        _messageStreamController.add(allPosts);

        //Save the last document from the resutls if it's the last page
        //Dokument braucht man um Pagination nacher richtig zu starten
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = postsSnapshot.docs.last;
        }

        //Dertermine if there are more posts to request
        _hasMorePosts = posts.length == 20;
      }
    });
  }
}
