import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/util/models/data_models.dart';

enum PostError {
  LocationDisabled,
  LocationDenied,
  LocationDeniedPermanently,
  FieldsMissing
}

///Handles Communication between Flutter and Firestore
class PostRepository {
  final FirebaseFirestore _firestore;
  late CollectionReference _postCollectionReference;

  PostRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _postCollectionReference = _firestore.collection('posts');
  }

  Stream<Post?> getPostStreamById(String? postId) {
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
      return null;
    });
  }

  /// Updates [post] Object in Firestore
  Future<void> updatePost(Post post) async {
    try {
      assert(post.id != null && post.id != '',
          'When updating a Post, Object must contain a valid Id');
      await _postCollectionReference.doc(post.id).update(post.toMap());
    } catch (err) {
      //return err as Exception;
    }
  }

  /// Creates a [post] Object in Firestore
  Future<void> createPost(Post post) async {
    try {
      post.geohash = await GeoService.getCurrentGeohash();
      await _postCollectionReference.add(post.toMap());
    } catch (err) {
      log("post: " + err.toString());
      return Future.error(err);
    }
  }

  static String titleFromPostDetailID(String id) {
    switch (id) {
      case "treffpunkt":
        return "Treffpunkt";
      case "kosten":
        return "Kosten pro Person";
      default:
        return "unbekannt";
    }
  }
}
