import 'package:flutter/material.dart';

/// Hält Daten zu verschiedenen Konstanten innerhalb der App.
///
/// Auslagerung in diese Klasse um die Konstanten an einem zentralen
/// Ort zu halten
class Presets {
  /// Liefert das aktuelle Theme der App zurück
  static ThemeData getThemeData() {
    return ThemeData(
      //TODO: set the values to their 'real' values

      // Basic colors
      brightness: Brightness.light,
      primaryColor: Colors.red[500],
      primaryColorLight: Colors.red[300],
      accentColor: Colors.lightGreenAccent,

      // Element Backgrounds
      scaffoldBackgroundColor: Colors.grey[200],
      cardColor: Colors.white,

      // Text Theme
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText1: TextStyle(
            fontSize: 14.0, fontFamily: "Roboto", color: Colors.grey[900]),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
}
