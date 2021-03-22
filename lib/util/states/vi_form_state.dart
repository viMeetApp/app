import 'package:flutter/widgets.dart';

@immutable

/// a simple state for form widgets in the viMeet app
class ViFormState {
  final bool isValid;
  final bool isSubmitting;
  final bool isError;
  final bool wasSubmitted;

  ViFormState(
      {required this.isValid,
      required this.isSubmitting,
      required this.isError,
      required this.wasSubmitted});
  factory ViFormState.okay() {
    return ViFormState(
        isValid: true,
        isSubmitting: false,
        isError: false,
        wasSubmitted: false);
  }

  factory ViFormState.loading() {
    return ViFormState(
        isValid: true, isSubmitting: true, isError: false, wasSubmitted: false);
  }
  factory ViFormState.invalid() {
    return ViFormState(
        isSubmitting: false,
        isValid: false,
        isError: false,
        wasSubmitted: false);
  }
  factory ViFormState.success() {
    return ViFormState(
        isSubmitting: false, isValid: true, isError: false, wasSubmitted: true);
  }
  factory ViFormState.error() {
    return ViFormState(
        isSubmitting: false, isValid: true, isError: true, wasSubmitted: false);
  }
}
