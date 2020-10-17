import 'dart:ui';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(
            image: AssetImage("assets/img/logo.png"),
          ),
        ),
      ),
    );
  }
}
