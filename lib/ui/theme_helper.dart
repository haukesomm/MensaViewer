import 'package:flutter/material.dart';


final Color lightThemePrimaryColor = Colors.indigo;

final Color lightThemeAccentColor = Colors.amber;

final Color darkThemePrimaryColor = Colors.blueAccent[100];

final Color darkThemeAccentColor = Colors.amber[300];


/// Returns the main theme for this app.
ThemeData getLighAppTheme() {
  return ThemeData(
    primarySwatch: lightThemePrimaryColor,
    accentColor: lightThemeAccentColor,

    textTheme: TextTheme(
      subtitle: TextStyle(
        color: lightThemeAccentColor
      ),
    ),
  );
}

/// Returns the dark theme for this app.
ThemeData getDarkAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkThemePrimaryColor,
    accentColor: darkThemeAccentColor,

    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Colors.grey[850],
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500
        )
      ),
      iconTheme: IconThemeData(
        color: Colors.white
      ),
    ),
    
    textTheme: TextTheme(
      subtitle: TextStyle(
        color: darkThemePrimaryColor
      ),
    ),
    
    toggleableActiveColor: darkThemeAccentColor,
  );
}