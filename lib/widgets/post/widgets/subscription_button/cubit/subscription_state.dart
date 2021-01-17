part of 'subscription_cubit.dart';

class SubscriptionState {
  SubscriptionState({bool subscribing, bool unsubscribing, bool error})
      : subscribing = subscribing ?? false,
        unsubscribing = unsubscribing ?? false,
        error = error ?? false;
  final bool subscribing;
  final bool unsubscribing;
  final bool error;

  factory SubscriptionState.empty() => SubscriptionState();
  factory SubscriptionState.subscribing() =>
      SubscriptionState(subscribing: true);
  factory SubscriptionState.unsubscribing() =>
      SubscriptionState(unsubscribing: true);
  factory SubscriptionState.onError() => SubscriptionState(error: true);
}
