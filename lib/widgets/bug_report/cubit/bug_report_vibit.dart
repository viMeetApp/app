import 'package:package_info/package_info.dart';
import 'package:signup_app/repositories/bugreport_repository.dart';
import 'package:signup_app/repositories/user_repository.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/vibit/vibit.dart';

enum Types { active, processing, submitted, invalid, error }

class BugReportPageState extends ViState {
  final BugReportRepository _bugRepository;
  Exception? error;
  String? title;
  BugReportType? kind;
  String? message;

  BugReportPageState(this._bugRepository) : super(type: Types.active);

  ///Document gets submitted (User Loggs in)
  ///Checks if User Name Valid the Log In
  void submitted() async {
    this.type = Types.processing;

    //Check if all fields were answered
    if (title != null && kind != null && message != null) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        User? user = await UserRepository().getUser();
        if (user == null) {
          throw Exception("active user is null");
        }

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
        print("Error in submitted Event");
        print(err.toString());
        error = err as Exception;
        this.type = Types.error;
      }
    } else {
      //Username invalid
      this.type = Types.invalid;
    }
  }
}
