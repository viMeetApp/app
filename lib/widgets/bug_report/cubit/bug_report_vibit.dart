import 'package:package_info/package_info.dart';
import 'package:signup_app/repositories/bugreport_repository.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/vibit/vibit.dart';

enum Types { active, processing, submitted, invalid, error }

class BugReportPageState extends ViState {
  final BugReportRepository _bugRepository;
  final AuthenticationService _authService;
  Exception? error;
  String? title;
  BugReportType? kind;
  String? message;

  BugReportPageState(
      {BugReportRepository? bugRepository,
      AuthenticationService? authenticationService})
      : _bugRepository = bugRepository ?? BugReportRepository(),
        _authService = authenticationService ?? AuthenticationService(),
        super(type: Types.active);

  ///Document gets submitted (User Loggs in)
  ///Checks if User Name Valid the Log In
  void submitted() async {
    this.type = Types.processing;

    //Check if all fields were answered
    if (title != null && kind != null && message != null) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        User user = _authService.getCurrentUser();

        BugReport report = new BugReport(
            title: title!,
            type: kind!,
            message: message!,
            author: user,
            version: packageInfo.version,
            reportedAt: DateTime.now().millisecondsSinceEpoch);

        await _bugRepository.createBugReport(bugReport: report);
        this.type = Types.submitted;
      } catch (err) {
        print("Error in submitted BugReport");
        this.type = Types.error;
      }
    } else {
      //Username invalid
      this.type = Types.invalid;
    }
  }
}
