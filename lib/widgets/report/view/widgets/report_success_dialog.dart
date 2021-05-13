import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signup_app/util/presets/presets.dart';

class ReportSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'report_success',
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
          color: AppThemeData.colorAccent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  color: AppThemeData.colorCard,
                  size: 100,
                ),
                Text("Danke!",
                    style: TextStyle(
                        color: AppThemeData.colorCard,
                        fontWeight: FontWeight.bold,
                        fontSize: 28)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
