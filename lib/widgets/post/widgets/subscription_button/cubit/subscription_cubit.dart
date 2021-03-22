import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:meta/meta.dart';

part 'subscription_state.dart';

///Cubit kümmert sich nur um an und abmlelden + später evtl. andere Authorisierung
///Ich habe das so gelöst, weil es jetzt ganz einfach ist Network Error events etc. zu bauen
///Ohne sich um den Rest des Cubits etc. zu kümmern
class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionState()) {
    //!Uncomment when testing Function in Emulator
    //functions.useFunctionsEmulator(origin: 'http://localhost:5001');
  }

  FirebaseFunctions functions = FirebaseFunctions.instance;

  ///Subscribe to Post by Calling the Cloud Function
  ///
  ///Ablauf: Cloud Function wird gecallt checkt ob man sich anmelden kann, Wenn ja verändert es den Eintrag in der Datenbank
  ///Anschließend sollte Post von selbst geupdated werden wegen snapshot
  void subscribe({required String postId}) {
    emit(SubscriptionState.subscribing());
    HttpsCallable callable = functions.httpsCallable(
      'subscribeToPost',
    );
    callable
        .call(<String, dynamic>{'postId': postId})
        .then((value) => print("Subscribed Sucessfully"))
        .catchError((err) => {
              emit(SubscriptionState.onError()),
              print("There was an error subscribing" + err.toString())
            });
  }

  ///Unsubscribe from Post by Calling the Cloud Function
  ///
  ///Ablauf: Cloud Function wird gecallt checkt ob man sich anmelden kann, Wenn ja verändert es den Eintrag in der Datenbank
  ///Anschließend sollte Post von selbst geupdated werden wegen snapshot
  void unsubscribe({required String postId}) {
    emit(SubscriptionState.unsubscribing());
    HttpsCallable callable = functions.httpsCallable(
      'unsubscribeFromPost',
    );
    callable
        .call(<String, dynamic>{'postId': postId})
        .then((value) => print("Unsubscribed Sucessfully"))
        .catchError((err) => {
              emit(SubscriptionState.onError()),
              print("There was an error unsubscribing" + err.toString())
            });
  }
}
