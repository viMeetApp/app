import 'package:flutter/widgets.dart';
import 'package:signup_app/util/presets.dart';

class SignUpWidgets {
  static Widget postDetailsFieldWidget({String name = "", String value = ""}) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppThemeData.varNormalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
          Expanded(
              child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600),
          ))
        ],
      ),
    );
  }
}
