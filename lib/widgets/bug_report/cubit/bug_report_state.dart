part of 'bug_report_cubit.dart';

@immutable
class BugReportState {
  final bool isValid;
  final bool isSubmitting;
  final bool isError;
  final bool wasSubmitted;

  BugReportState(
      {@required this.isValid,
      @required this.isSubmitting,
      @required this.isError,
      @required this.wasSubmitted});
  factory BugReportState.empty() {
    return BugReportState(
        isValid: true,
        isSubmitting: false,
        isError: false,
        wasSubmitted: false);
  }

  factory BugReportState.loading() {
    return BugReportState(
        isValid: true, isSubmitting: true, isError: false, wasSubmitted: false);
  }
  factory BugReportState.failure() {
    return BugReportState(
        isSubmitting: false,
        isValid: false,
        isError: false,
        wasSubmitted: false);
  }
  factory BugReportState.success() {
    return BugReportState(
        isSubmitting: false, isValid: true, isError: false, wasSubmitted: true);
  }
  factory BugReportState.error() {
    return BugReportState(
        isSubmitting: false, isValid: true, isError: true, wasSubmitted: false);
  }
}
