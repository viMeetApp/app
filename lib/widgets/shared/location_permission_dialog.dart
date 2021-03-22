import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/home_feed/location_widget/cubit/location_widget_vibit.dart';

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
