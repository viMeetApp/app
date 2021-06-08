import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup_app/services/geo_services/classes.dart';
import 'package:signup_app/services/geo_services/geo_locator.dart';
import 'package:signup_app/common.dart';

///Class used for Pagination of Posts and Filtering all other post Network Calls are made Via PostRepository
class PostPagination {
  final GeoLocator _geoLocator;
  PostPagination(
      {this.group,
      this.paginationDistance = 20,
      GeoLocator? geoLocator,
      this.user})
      : _geoLocator = geoLocator ?? GeoLocator();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Current Stack of all listeners -> when a new query has been started all old listeners must be closed
  List<StreamSubscription<QuerySnapshot>> _currentFirestoreListenerStack = [];

  //Variables Necessary for Pagination
  StreamController<List<Post>> postStreamController =
      new StreamController<List<Post>>();
  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  List<List<Post>> _allPagedResults = [];
  //How many Items get paginated every time
  final paginationDistance;

  //Variables Necessary for Filtering
  List<String>? tags;
  final Group? group;
  final UserReference? user;

  //Query
  Query? postQuery;

  ///Fuction to Call when New Query Stars
  ///For examlpe at beginning or after Filter Changes
  void newQuery({List<PostTag> tags = const []}) async {
    _removeCurrentListenerStack();
    //Reset all Variables
    _hasMorePosts = true;
    _lastDocument = null;
    _allPagedResults = [];
    tags = tags;
    postQuery = null;
    //Create Matching Query to all Filters
    CollectionReference colReference = _firestore.collection('posts');
    Query query;
    //First Check for Group (if Group Provided only Show Posts from Group)
    if (group != null) {
      query = colReference.where("group.id", isEqualTo: group!.id);
    } else if (user != null) {
      query = colReference.where("participants",
          arrayContains: user!.toMap(includeID: true));
    }
    //ToDO Frage soll wenn man in gruppe ist trotzdem nach ort gefiltert werden?
    else {
      GeohashRange range = _geoLocator.getGeohashRange();
      query = colReference
          .where("geohash", isGreaterThanOrEqualTo: range.lower)
          .where("geohash", isLessThanOrEqualTo: range.upper);
    }

    // Filter for tags
    if (tags.length > 0) {
      String queryString = "";
      tags.forEach((PostTag tag) {
        queryString = queryString += (enumToString(tag) + ',');
      });
      queryString = queryString.substring(0, queryString.length - 1);
      print(queryString);

      query = query.where('searchableTags', arrayContains: queryString);
    }

    postQuery = query.limit(paginationDistance);
    requestPosts();
  }

  void requestPosts() {
    //If there are no mor posts return
    if (!_hasMorePosts) return;
    //If there is a last Document we paginate therefore gettin data after last Document
    if (_lastDocument != null) {
      postQuery = postQuery!.startAfterDocument(_lastDocument!);
    }
    //Index how often we already fetched new data -> Number of Lists in big List
    int currentRequestIndex = _allPagedResults.length;

    //Callbackfunction is called every Time a Document updates itself
    StreamSubscription<QuerySnapshot> currentSnapshotListener =
        postQuery!.snapshots().listen((QuerySnapshot postsSnapshot) {
      print("Post listen");
      if (postsSnapshot.docs.isNotEmpty) {
        List<Post> posts = postsSnapshot.docs.map(
          (QueryDocumentSnapshot snapshot) {
            if (snapshot.get('type') == "event") {
              return Event.fromDoc(snapshot);
            } else {
              return Buddy.fromDoc(snapshot);
            }
          },
        ).toList();

        posts.sort((a, b) {
          if (a.createdAt <= b.createdAt)
            return 1;
          else
            return -1;
        });

        //Check if page exists or is new page (hier könnte es etwas verwirrend sein, da man ja currenRequestIndex oben setzt)
        //Die Sache ist aber, dass das hier drinnen ja eine Callaback Funktion ist. Das heißt zeug kann sich hier auch ändern
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
        List<Post> allPosts = _allPagedResults.fold<List<Post>>(
            [], (initialValue, pageItems) => initialValue..addAll(pageItems));

        //Broadcast all posts
        postStreamController.add(allPosts);

        //Save the last document from the result if it's the last page
        //Dokument braucht man um Pagination nachher richtig zu starten
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = postsSnapshot.docs.last;
        }

        //Dertermine if there are more posts to request
        _hasMorePosts = posts.length == paginationDistance;
      } else {
        postStreamController.add([]);
      }
    });
    _currentFirestoreListenerStack.add(currentSnapshotListener);
  }

  void _removeCurrentListenerStack() {
    _currentFirestoreListenerStack
        .forEach((StreamSubscription<QuerySnapshot> listener) {
      listener.cancel();
    });
    _currentFirestoreListenerStack = [];
  }
}
