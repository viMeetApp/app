import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.all(0),
        child: Padding(
            padding: EdgeInsets.all(30), child: Text("TODO: Ortsauswahl")),
      ),
    );
  }
}
