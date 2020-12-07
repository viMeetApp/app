import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/util/data_models.dart';

part 'post_detailed_state.dart';

class PostdetailedCubit extends Cubit<PostDetailedState> {
  Post post;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  PostdetailedCubit({@required this.post})
      : assert(post != null),
        super(Uninitialized()) {
    if (post.type == 'event') {
      emit(EventState(post: post));
    } else if (post.type == 'buddy') {
      emit(BuddyState());
    }
    //Im ersten Schritt wird Bloc mit einer geladenen Gruppe versorgt,
    //um aber dynamisches zu behalten wird gleichzeitig verbindung zu Firestore aufgebaut
    //um ab da dynamische Gruppe zu haben.
    _firestore
        .collection('posts')
        .doc(post.id)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print("Firestore");
        if (documentSnapshot['type'] == 'event') {
          emit(EventState(post: Event.fromDoc(documentSnapshot)));
        } else if (documentSnapshot['type'] == 'buddy') {
          emit(BuddyState());
        }
      }
    });
  }

  ///Toggle if Top Card is Expanded
  void toggleExpanded() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  ///Fold in the Top Card
  void foldIn() {
    if (state.isExpanded) emit(state.copyWith(isExpanded: false));
  }

  ///Function to call if Favourite Icon in pressed
  ///At the Moment just toggles State
  void favourite() {
    emit(state.copyWith(isFavourite: !state.isFavourite));
  }
}
