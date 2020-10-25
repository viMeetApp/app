import 'package:flutter/material.dart';

/// Hält Daten zu verschiedenen Konstanten innerhalb der App.
///
/// Auslagerung in diese Klasse um die Konstanten an einem zentralen
/// Ort zu halten
class Presets {
  // preset component decoration
  static InputDecoration getTextFieldDecoration(
      {String hintText = "",
      String errorText,
      Color fillColor = AppThemeData.colorCard,
      Color hintColor = AppThemeData.colorControls}) {
    return InputDecoration(
      hintStyle: TextStyle(color: hintColor),
      hintText: hintText,
      errorText: errorText,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      fillColor: fillColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppThemeData.colorPrimary, width: 3.0),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static AppBarTheme getAppBarTheme(
      {Color color = Colors.transparent,
      Color elementsColor = AppThemeData.colorControls}) {
    return AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: elementsColor),
    );
  }
}

class AppThemeData {
  final Brightness brightness = Brightness.light;

  // define accent colors
  // current color scheme: https://coolors.co/1a535c-4ecdc4-f7fff7-ff6b6b-ffe66d
  static const Color colorPrimary = Color(0xFFFF6b6b);
  static const Color colorPrimaryLight = Color(0xffff7777);
  static const Color colorAccent = Color(0xff4ecdca);
  static const Color colorControls = Color(0xff383838);

  static final ColorSwatch swatchPrimary =
      MaterialColor(Color(0xFFFF6b6b).value, {
    50: Color(0xFFFFdddd),
    100: Color(0xFFFFc2c2),
    200: Color(0xFFFF9999),
    300: Color(0xFFFF6b6b),
    400: Color(0xFFFF5555),
    500: Color(0xFFFF3333),
    600: Color(0xFFFF1111),
    700: Color(0xFFee0000),
    800: Color(0xFFcc0000),
    900: Color(0xFFaa0000),
  });

  // define basic colors
  static const Color colorBase = Color(0xffeeeeee);
  static const Color colorCard = Colors.white;
  static const Color colorTextRegular = Color(0xff333333);
  static const Color colorTextInverted = Colors.white;

  // define 'real' colors
  static const Color colorWhiteTrans = Color(0x14ffffff);
  static const Color colorBlackTrans = Color(0x14000000);

  // define basic variables
  static const double varNormalPadding = 10;
  static const String varFontFace = "Roboto";
  static const Radius varChatBubbleRadius = Radius.circular(12);
  static const Radius varCardRadius = Radius.circular(10);

  /// defining a material theme
  ThemeData get materialTheme {
    return ThemeData(
      // Basic colors
      brightness: brightness,
      primaryColor: colorPrimary,
      primaryColorLight: colorPrimaryLight,
      accentColor: colorAccent,

      primarySwatch: swatchPrimary,

      // Element Backgrounds
      scaffoldBackgroundColor: colorBase,
      cardColor: colorCard,

      appBarTheme: Presets.getAppBarTheme(),

      // Element themes
      buttonTheme: ButtonThemeData(
        minWidth: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.transparent)),
        buttonColor: colorPrimary,
        textTheme: ButtonTextTheme.primary,
      ),

      // Text Theme
      primaryTextTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 18.0, color: colorControls, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(
            fontSize: 14.0, fontFamily: "Roboto", color: colorTextInverted),
        bodyText2: TextStyle(
            fontSize: 14.0, fontFamily: "Roboto", color: colorTextRegular),
      ),
    );
  }
}
