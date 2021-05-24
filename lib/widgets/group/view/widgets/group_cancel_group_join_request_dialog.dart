import 'package:flutter/material.dart';
import 'package:signup_app/common.dart';

class CancelGroupJoinRequestDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.all(10),
      title: Text("Anfrage zurückziehen?"),
      content:
          Text("Möchtest du deine Beitritts-Anfrage wirklich zurückziehen?"),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: Text("nein")),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Tools.showSnackbar(context, "ToDo implemete withdraw");
          },
          child: Text("ja"),
        )
      ],
    );
  }
}
