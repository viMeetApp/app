import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:signup_app/util/data_models.dart';

enum PostErrors { LocationDisabled, LocationDenied, LocationDeniedPermanently }

///Handles Communication between Flutter and Firestore
class PostRepository {
  final geo = Geoflutterfire();
  final FirebaseFirestore _firestore;
  CollectionReference _postCollectionReference;

  PostRepository({FirebaseFirestore firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _postCollectionReference = _firestore.collection('posts');
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
      return null;
    });
  }

  /// Updates [post] Object in Firestore
  Future<void> updatePost(Post post) async {
    try {
      assert(post.id != null && post.id != '',
          'When updating a Post, Object must contain a valid Id');
      await _postCollectionReference.doc(post.id).update(post.toDoc());
    } catch (err) {
      throw err;
    }
  }

  /// Creates a [post] Object in Firestore
  Future<void> createPost(Post post) async {
    try {
      post.geohash = await _getCurrentGeohash();
      await _postCollectionReference.add(post.toDoc());
    } catch (err) {
      throw err;
    }
  }

  Future<String> _getCurrentGeohash() async {
    try {
      LocationData position = await _getDeviceLocation();
      String geohash = geo
          .point(latitude: position.latitude, longitude: position.longitude)
          .hash;
      return geohash.substring(0, 5); // return a geohash with limited accuracy
    } catch (err) {
      print(err.toString());
      return err;
    }
  }

  Future<LocationData> _getDeviceLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error(PostErrors.LocationDisabled);
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return Future.error(PostErrors.LocationDenied);
      }
    }

    return await location.getLocation();
  }

  /*Future<Position> _getDevicePositionOLD() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(PostErrors.LocationDisabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(PostErrors.LocationDeniedPermanently);
      }

      if (permission == LocationPermission.denied) {
        return Future.error(PostErrors.LocationDisabled);
      }
    }
    return await Geolocator.getCurrentPosition();
  }*/
}
