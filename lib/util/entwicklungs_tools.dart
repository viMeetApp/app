import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EntwicklungsTools {
  static Widget getTODOWidget(String message) {
    return Container(
        margin: EdgeInsets.only(bottom: 20, top: 10),
        padding: EdgeInsets.all(20),
        //height: state.expanded ? 500 : 0,
        //constraints: BoxConstraints(),
        decoration: new BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: Colors.orange[300] ?? Colors.orange, width: 2),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 20.0,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "TODO",
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Expanded(
              child: Text(
                message,
                softWrap: true,
              ),
            ),
          ],
        ));
  }
}
