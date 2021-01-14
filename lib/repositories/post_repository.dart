import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/util/data_models.dart';

///Handles Communication between Flutter and Firestore
class PostRepository {
  final FirebaseFirestore _firestore;
  CollectionReference _postCollectionReference;

  PostRepository({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _postCollectionReference = _firestore.collection('posts');
  }

  ///Creates a [post] Object in Firestore
  Future<void> createPost(Post post) async {
    try {
      await _postCollectionReference.add(post.toDoc());
    } catch (err) {
      throw err;
    }
  }

  ///Updates [post] Object in Firestore
  Future<void> updatePost(Post post) async {
    try {
      assert(post.id != null && post.id != '',
          'When updating a Post, Object must contain a valid Id');
      await _postCollectionReference.doc(post.id).update(post.toDoc());
    } catch (err) {
      throw err;
    }
  }

  Stream<Post> getPostStreamById(String postId) {
    return _postCollectionReference
        .doc(postId)
        .snapshots()
        .map((DocumentSnapshot doc) {
      if (doc.exists) {
        if (doc['type'] == 'event') {
          return Event.fromDoc(doc);
        } else {
          return Buddy.fromDoc(doc);
        }
      }
    });
  }
}
