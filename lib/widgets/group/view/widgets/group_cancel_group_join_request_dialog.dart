import 'package:flutter/material.dart';

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
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop(false),
            child: Text("nein")),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(true);
          },
          child: Text("ja"),
        )
      ],
    );
  }
}
