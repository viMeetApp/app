import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_app/util/debug_tools.dart';
import 'package:signup_app/util/presets.dart';

//ToDo Bin mir nicht sicher ob das so gut ist mit Klasse oder Static besser wäre
///Helper Class which extracts the Logic for Using Popup Dialogs
class ViDialog {
  ViDialog();
  static Future showWidgetDialog(
      {@required context,
      @required Widget child,
      @required String title,
      @required Function onOkay,
      bool noActions = false}) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: AppThemeData.textHeading3(),
                ),
                Container(
                  //color: Colors.red,
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  child: child,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!noActions)
                      FlatButton(
                          onPressed: () => {Navigator.pop(context, null)},
                          child: Text("Abbrechen")),
                    FlatButton(
                        onPressed: noActions
                            ? () => {Navigator.pop(context, null)}
                            : onOkay,
                        child: Text("Ok"))
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

    return showWidgetDialog(
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

    return showWidgetDialog(
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
