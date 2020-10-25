
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/util/DataModels.dart';

class PostRepository{
  final FirebaseFirestore _firestore;

  PostRepository({FirebaseFirestore firestore})
  :_firestore=firestore??FirebaseFirestore.instance;

  ///Return a Single Post (Event or Buddy) by using the unique Id
  Future<Post> getPost(String postId)async{
    DocumentSnapshot doc=(await _firestore.collection('posts').doc(postId).get());
    //Check for What Type Objet
    if(doc['type']=="event"){
      return Event.fromJson(doc.data(),doc.id);
    }
    else if(doc['type']=="buddy"){
      return Buddy.fromJson(doc.data(), doc.id);
    }
  }

  //Todo Was passiert wenn wir hier einen Network Error bekommen
  Future<void> updatePost(Post post){
    return _firestore.collection('posts').doc(post.id).update(post.toJson());
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
      return Event.fromJson(doc.data(), doc.id);
    }
    else if(doc['type']=="buddy"){
      return Buddy.fromJson(doc.data(),doc.id);
    }
    }).toList());

    return postStream;
  }


//!Etwas gecheatete Lösung -> lädt einfach alle passenden herunter
  Stream<List<Post>> getPostsFitlered(List<String> tags){
    //Todo Filter for Query
    CollectionReference colReference=_firestore.collection('posts');
    Stream<QuerySnapshot> snap;
    
    //var query= _firestore.collection('posts'); 
    if(tags!=null&&tags.length!=0){
    Query query=colReference.where("tags",arrayContains: tags[0]);
    for(int i=1; i<tags.length;++i){
      query=query.where("tags",arrayContains: tags[i]);
    }
      snap=query.snapshots();
    }
    else{
      snap=colReference.snapshots();
    }
   
    //Map Stream of Query Snapshots to Stream of Post Objects
    Stream<List<Post>> postStream= snap.map((list) {
    
    List<Post> postList=list.docs.map((doc) {
      if(doc['type']=="event"){
      return Event.fromJson(doc.data(), doc.id);
    }
    else if(doc['type']=="buddy"){
      return Buddy.fromJson(doc.data(),doc.id);
    }
    }).toList();
    postList.sort((a,b){
      if(a.createdDate<=b.createdDate) return 1;
      else return -1;
    });
    return postList;
    });

    return postStream;
  }
  

  //ToDo Pagination Function

}