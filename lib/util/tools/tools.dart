import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:signup_app/util/widgets/success_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools {
  static openUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  static showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
      ));
  }

  static showSuccessPage(BuildContext context, {String? message}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SuccessPage(
        message: message,
      );
    }));
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  static String dateFromEpoch(int epoch) {
    return DateFormat('dd.MM.yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(epoch));
  }

  static String readableDateFromDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  static String timeFromEpoch(int epoch) {
    return DateFormat('hh:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(epoch));
  }

  static String readableTimeFromTimeOfDay(TimeOfDay timeOfDay) {
    return timeOfDay.toString().substring(10, 15);
  }
}
