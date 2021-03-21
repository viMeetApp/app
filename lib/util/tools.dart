import 'package:url_launcher/url_launcher.dart';

class Tools {
  static openUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
