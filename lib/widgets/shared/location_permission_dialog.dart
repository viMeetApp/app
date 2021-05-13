import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/presets/presets.dart';

class LocationPermissionDialog extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        heightFactor: 0.6,
        child: Card(
          color: AppThemeData.colorBase,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.all(AppThemeData.varPaddingCard * 3),
          child: Column(
            children: [Text("Location Dialog")],
          ),
        ),
      ),
    );
  }
}
