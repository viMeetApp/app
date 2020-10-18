import 'package:flutter/material.dart';

/// Hält Daten zu verschiedenen Konstanten innerhalb der App.
///
/// Auslagerung in diese Klasse um die Konstanten an einem zentralen
/// Ort zu halten
class Presets {}

class AppThemeData {
  final Brightness brightness = Brightness.light;

  // define accent colors

  final ColorSwatch swatchPrimary = MaterialColor(0xffff7777, {
    50: Color(0xFFFFdddd),
    100: Color(0xFFFFbbbb),
    200: Color(0xFFFF9999),
    300: Color(0xFFFF7777),
    400: Color(0xFFFF5555),
    500: Color(0xFFFF3333),
    600: Color(0xFFFF1111),
    700: Color(0xFFee0000),
    800: Color(0xFFcc0000),
    900: Color(0xFFaa0000),
  });

  final Color colorPrimary = Colors.red;
  final Color colorPrimaryLight = Color(0xffff7777);
  final Color colorAccent = Color(0xff77ff77);
  final Color colorControls = Color(0xff383838);

  // define basic colors
  final Color colorBase = Colors.grey[200];
  final Color colorCard = Colors.white;
  final Color colorTextRegular = Colors.grey[900];
  final Color colorTextInverted = Colors.white;

  // define basic variables
  final String varFontFace = "Roboto";
  final Radius varChatBubbleRadius = Radius.circular(12);

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

      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorControls),
      ),

      // Element themes
      buttonTheme: ButtonThemeData(
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
