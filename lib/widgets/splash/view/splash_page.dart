import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signup_app/util/presets/presets.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.colorPrimary,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.4,
          child: Image(
            image: AssetImage("assets/img/brand/logo_light_text_trans.png"),
          ),
        ),
      ),
    );
  }
}
