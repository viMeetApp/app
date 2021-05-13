import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/services/geo_services/geo_locator.dart';
import 'package:signup_app/common.dart';

enum PostError {
  LocationDisabled,
  LocationDenied,
  LocationDeniedPermanently,
  FieldsMissing
}

///Handles Communication between Flutter and Firestore
class PostRepository {
  final FirebaseFirestore _firestore;
  final GeoLocator _geoLocator;
  late CollectionReference _postCollectionReference;

  PostRepository({FirebaseFirestore? firestore, GeoLocator? geoLocator})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _geoLocator = geoLocator ?? GeoLocator() {
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
      assert(post.id != '',
          'When updating a Post, Object must contain a valid Id');
      await _postCollectionReference.doc(post.id).update(post.toMap());
    } catch (err) {
      //return err as Exception;
    }
  }

  /// Creates a [post] Object in Firestore
  Future<void> createPost(Post post) async {
    try {
      post.geohash = await _geoLocator.getCurrentGeohash();
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
