import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Hält Daten zu verschiedenen Konstanten innerhalb der App.
///
/// Auslagerung in diese Klasse um die Konstanten an einem zentralen
/// Ort zu halten
class Presets {
  // preset component decoration
  static InputDecoration getTextFieldDecorationHintStyle(
      {String hintText = "",
      IconButton suffixIcon,
      String errorText,
      Color fillColor = AppThemeData.colorCard,
      TextStyle hintStyle}) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: hintStyle ?? TextStyle(color: AppThemeData.colorControls),
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

  static InputDecoration getTextFieldDecorationLabelStyle(
      {String labelText = "",
      String errorText,
      Color fillColor = AppThemeData.colorCard,
      Color hintColor = AppThemeData.colorControls}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: hintColor),
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

  static Widget getSignUpCard({@required Widget child}) {
    return Container(
      padding: EdgeInsets.all(AppThemeData.varPaddingCard),
      decoration: BoxDecoration(
          color: AppThemeData.colorCard,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.all(AppThemeData.varCardRadius)),
      child: child,
    );
  }
}

class AppThemeData {
  final Brightness brightness = Brightness.light;

  // define accent colors
  // current color scheme: https://coolors.co/1a535c-4ecdc4-f7fff7-ff6b6b-ffe66d
  static const Color colorPrimary = Color(0xFFFF5555);
  static const Color colorPrimaryLight = Color(0xffff7777);
  static const Color colorPrimaryLighter = Color(0xffffa4a4);
  static const Color colorAccent = Color(0xff4ecdca);
  static const Color colorControls = Color(0xff383838);
  static const Color colorControlsDisabled = Color(0xff9f9f9f);
  static const Color colorFormField = Color(0xff505050);
  static const Color colorPlaceholder = Color(0xff606060);

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
  static const Color colorTextRegularLight = Color(0xff777777);
  static const Color colorTextInverted = Colors.white;

  // define 'real' colors
  static const Color colorWhiteTrans = Color(0x14ffffff);
  static const Color colorBlackTrans = Color(0x14000000);

  // define font sizes
  static TextStyle textFormField({Color color = colorFormField}) =>
      TextStyle(color: color, fontSize: 16);
  static TextStyle textNormal({Color color = colorControls}) =>
      TextStyle(color: color, fontSize: 14);
  static TextStyle textHeading1({Color color = colorControls}) =>
      TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle textHeading2({Color color = colorControls}) =>
      TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle textHeading3({Color color = colorControls}) =>
      TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle textHeading4({Color color = colorControls}) =>
      TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold);

  // define basic variables
  static const double varPaddingNormal = 10;
  static const double varPaddingEdges = 8;
  static const double varPaddingCard = 15;
  static const String varFontFace = "Roboto";
  static const Radius varChatBubbleRadius = Radius.circular(12);
  static const Radius varCardRadius = Radius.circular(10);

  static final uiOverlayStyleThemed = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: AppThemeData.colorPrimary);

  static final uiOverlayStyle = SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: colorCard,
      systemNavigationBarIconBrightness: Brightness.dark);

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
      dividerColor: Colors.transparent,

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
