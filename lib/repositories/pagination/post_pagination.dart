import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/util/data_models.dart';

//ToDo Das Problem im Moment ist es, dass ich alte Suchen nicht gecancelt bekomme, sie laufen die ganze Zeit im Hintergrund. Es wird zwar durch einen Counter sichergestellt, dass sie keinen Einfluss haben, schöner wäre es aber wenn ich sie Stoppen könnte
///Class used for Pagination of Posts and Filtering all other post Network Calls are made Via PostRepository
class PostPagination {
  final geo = Geoflutterfire();
  PostPagination({required this.paginationDistance, this.user, this.group});
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Counter Variable to only update current Streams
  int counter = 0;
  //Variables Necessary for Pagination
  StreamController<List<Post?>> postStreamController =
      new StreamController<List<Post?>>();
  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  List<List<Post?>> _allPagedResults = [];
  //How many Items get paginated every time
  final paginationDistance;

  //Variables Necessary for Filtering
  List<String>? tags;
  final Group? group;
  final User? user;

  //Query
  Query? postQuery;

  ///Fuction to Call when New Query Stars
  ///For examlpe at beginning or after Filter Changes
  void newQuery({List<String?>? tags}) async {
    counter++;
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
      query =
          colReference.where("group.id", isEqualTo: group!.id).where("geohash");
    }
    //Then Check for User (if User provided only show Posts from User)
    else if (user != null) {
      query = colReference.where("participants", arrayContains: user!.id);
    }

    //! Filtering nach Tags muss ggf. lokal passieren wenn nach Ort gefiltert werden soll :/
    //After that Filter for Tags
    /*else if (tags != null && tags.length != 0) {
      query = query != null
          ? query.where("tags.${tags[0]}", isEqualTo: true)
          : colReference.where("tags.${tags[0]}", isEqualTo: true);
      for (int i = 1; i < tags.length; ++i) {
        query = query.where("tags.${tags[i]}", isEqualTo: true);
      }
    }*/

    else {
      GeohashRange range = GeoService.getGeohashRange();
      query = colReference
          .where("geohash", isGreaterThanOrEqualTo: range.lower)
          .where("geohash", isLessThanOrEqualTo: range.upper);
    }

    postQuery = query.limit(paginationDistance);
    requestPosts();
  }

  void requestPosts() {
    int localCounter = counter;

    //If there are no mor posts return
    if (!_hasMorePosts) return;
    //If there is a last Document we paginate therefore gettin data after last Document
    if (_lastDocument != null) {
      postQuery = postQuery!.startAfterDocument(_lastDocument!);
    }
    //Index how often we already fetched new data -> Number of Lists in big List
    int currentRequestIndex = _allPagedResults.length;

    //Callbackfunction is called every Time a Document updates itself
    postQuery!.snapshots().listen((QuerySnapshot postsSnapshot) {
      if (counter == localCounter) {
        if (postsSnapshot.docs.isNotEmpty) {
          List<Post?> posts =
              postsSnapshot.docs.map((QueryDocumentSnapshot snapshot) {
            // document.putIfAbsent("id", () => doc.id);
            if (snapshot.data()!['type'] == "event") {
              return Event.fromDoc(snapshot);
            } else if (snapshot.data()!['type'] == "buddy") {
              return Buddy.fromDoc(snapshot);
            }
          }).toList();
          posts.sort((a, b) {
            if (a!.createdDate! <= b!.createdDate!)
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
          List<Post?> allPosts = _allPagedResults.fold<List<Post?>>(
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
      }
    });
  }
}
