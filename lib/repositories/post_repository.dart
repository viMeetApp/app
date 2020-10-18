
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/util/DataModels.dart';

class PostRepository{
  final FirebaseFirestore _firestore;

  PostRepository({FirebaseFirestore firestore})
  :_firestore=firestore??FirebaseFirestore.instance;

  ///Return a Single Post (Event or Buddy) by using the unique Id
  Future<Post> getPost(String postId)async{
    Map snap=(await _firestore.collection('posts').doc(postId).get()).data();
    //Check for What Type Objet
    if(snap['type']=="event"){
      return Event.fromJson(snap);
    }
    else if(snap['type']=="buddy"){
      return Buddy.fromJson(snap);
    }
  }

  ///Return Stream of all Posts matching the [searchQuery]
  ///Returns 20 Objects
  ///Todo Implement a Search Query
  Stream<List<Post>> getPosts(String searchQuery){
    //Todo Filter for Query
    Stream<QuerySnapshot> querySnap= _firestore.collection('posts').orderBy('createdDate',descending: true).limit(20).snapshots();

    //Map Stream of Query Snapshots to Stream of Post Objects
    Stream<List<Post>> postStream= querySnap.map((list) => list.docs.map((doc) {
      if(doc['type']=="event"){
      return Event.fromJson(doc.data());
    }
    else if(doc['type']=="buddy"){
      return Buddy.fromJson(doc.data());
    }
    }).toList());

    return postStream;
  }

  //ToDo Pagination Function

}