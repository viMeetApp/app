import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/util/data_models.dart';

class PostRepository {
  final FirebaseFirestore _firestore;

  PostRepository({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  ///Return a Single Post (Event or Buddy) by using the unique Id
  Future<Post> getPost(String postId) async {
    DocumentSnapshot doc =
        (await _firestore.collection('posts').doc(postId).get());
    //Check for What Type Objet

    Map<String, dynamic> document = doc.data();
    document.putIfAbsent("id", () => doc.id);

    if (doc['type'] == "event") {
      return Event.fromJson(document);
    } else if (doc['type'] == "buddy") {
      return Buddy.fromJson(document);
    }
  }

  //Todo Was passiert wenn wir hier einen Network Error bekommen
  Future<void> updatePost(Post post) {
    return _firestore.collection('posts').doc(post.id).update(post.toJson());
  }

  ///Return Stream of all Posts matching the [searchQuery]
  ///Returns 20 Objects
  ///Todo Implement a Search Query
  Stream<List<Post>> getPosts(String searchQuery) {
    //Todo Filter for Query
    Stream<QuerySnapshot> querySnap = _firestore
        .collection('posts')
        .orderBy('createdDate', descending: true)
        .limit(20)
        .snapshots();

    //Map Stream of Query Snapshots to Stream of Post Objects
    Stream<List<Post>> postStream =
        querySnap.map((list) => list.docs.map((doc) {
              Map<String, dynamic> document = doc.data();
              document.putIfAbsent("id", () => doc.id);
              if (doc['type'] == "event") {
                return Event.fromJson(document);
              } else if (doc['type'] == "buddy") {
                return Buddy.fromJson(document);
              }
            }).toList());

    return postStream;
  }

//!Funktion nicht anfassen ist nicht schöne ich überarbeite Sie wenn wir mehr Post Objekte zum Testen haben

  Stream<List<Post>> getPostsFitlered({List<String> tags, Group group}) {
    //Todo Filter for Query
    CollectionReference colReference = _firestore.collection('posts');
    Stream<QuerySnapshot> snap;
    Query query;
    //First Check for Group (if it's feed in Group only show Post from Group)
    if (group != null) {
      query = colReference.where("group.id", isEqualTo: group.id);
    }
    //var query= _firestore.collection('posts');
    if (tags != null && tags.length != 0) {
      query = query != null
          ? query.where("tags.${tags[0]}", isEqualTo: true)
          : colReference.where("tags.${tags[0]}", isEqualTo: true);
      for (int i = 1; i < tags.length; ++i) {
        query = query.where("tags.${tags[i]}", isEqualTo: true);
      }
      snap = query
          .snapshots(); //orderBy('createdDate',descending: true).snapshots();
    }

    //Get snapshorts filtered correctly
    snap = query != null ? query.snapshots() : colReference.snapshots();

    //Map Stream of Query Snapshots to Stream of Post Objects
    Stream<List<Post>> postStream = snap.map((list) {
      List<Post> postList = list.docs.map((doc) {
        Map<String, dynamic> document = doc.data();
        document['id'] = doc.id;
        // document.putIfAbsent("id", () => doc.id);
        if (doc['type'] == "event") {
          return Event.fromJson(document);
        } else if (doc['type'] == "buddy") {
          return Buddy.fromJson(document);
        }
      }).toList();
      postList.sort((a, b) {
        if (a.createdDate <= b.createdDate)
          return 1;
        else
          return -1;
      });
      return postList;
    });

    return postStream;
  }

  //ToDo Pagination Function

}
