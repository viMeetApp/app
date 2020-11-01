import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:signup_app/util/data_models.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GroupCubit({@required Group group}) : super(GroupState(group: group)) {
    //Im ersten Schritt wird Bloc mit einer geladenen Gruppe versorgt,
    //um aber dynamisches zu behalten wird gleichzeitig verbindung zu Firestore aufgebaut
    //um ab da dynamische Gruppe zu haben.
    _firestore
        .collection('groups')
        .doc(group.id)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        emit(GroupState(
            group: Group.fromJson(documentSnapshot.data())
              ..setID(documentSnapshot.id)));
      }
    });
  }
}
