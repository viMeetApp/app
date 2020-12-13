import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_app/util/debug_tools.dart';
import 'package:signup_app/util/presets.dart';

//ToDo Bin mir nicht sicher ob das so gut ist mit Klasse oder Static besser wäre
///Helper Class which extracts the Logic for Using Popup Dialogs
class DialogHelper {
  DialogHelper();
  static Future _showDialog(
      {@required context,
      @required Widget child,
      @required String title,
      @required Function onOkay}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0.0,
          backgroundColor: AppThemeData.colorBase,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Wrap(
              children: [
                Text(
                  title,
                  style: AppThemeData.textHeading3(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  child: child,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        onPressed: () => {Navigator.pop(context, null)},
                        child: Text("Abbrechen")),
                    FlatButton(onPressed: onOkay, child: Text("Ok"))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future showTextInputDialog(
      {@required context,
      String title = "",
      String currentValue = "",
      List<TextInputFormatter> formatters,
      TextInputType keyboardType = TextInputType.text}) {
    Function onOkay = () {
      viLog(context, currentValue);
      Navigator.pop(context, currentValue);
    };

    return _showDialog(
        context: context,
        title: title,
        child: Wrap(
          children: [
            TextFormField(
              autofocus: true,
              initialValue: currentValue,
              onChanged: (text) {
                currentValue = text;
              },
              keyboardType: keyboardType,
              inputFormatters: formatters,
              decoration: Presets.getTextFieldDecorationHintStyle(),
            ),
          ],
        ),
        onOkay: onOkay);
  }

  static Future showTextInputDialogMultiline(
      {@required context,
      int minLine = 3,
      int maxLine = 5,
      String title = "",
      String currentValue = "",
      List<TextInputFormatter> formatters,
      TextInputType keyboardType = TextInputType.text}) {
    Function onOkay = () {
      viLog(context, currentValue);
      Navigator.pop(context, currentValue);
    };

    return _showDialog(
        context: context,
        title: title,
        child: TextFormField(
          minLines: minLine,
          maxLines: maxLine,
          autofocus: true,
          initialValue: currentValue,
          onChanged: (text) {
            currentValue = text;
          },
          keyboardType: keyboardType,
          inputFormatters: formatters,
          decoration: Presets.getTextFieldDecorationHintStyle(),
        ),
        onOkay: onOkay);
  }
}
