import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Wrapper for a SharedPreferences key including the key itself, it's type,
/// and a default value that can be used if no value is assiciated with the
/// preference yet.
/// 
/// The helper functions in this package do not take regular String keys but
/// objects of this class instead.
/// 
/// All known preference keys are defined as top-level constants within this
/// package.
class PreferenceKey {

  final String key;
  final Type type;
  final dynamic defaultValue;

  const PreferenceKey._({
    @required this.key, 
    @required this.type, 
    @required this.defaultValue
  });
}


//---------------------------------------------------------------------------
//
//  Preference-key-definitions
//
//---------------------------------------------------------------------------

const userIsStaff = 
  PreferenceKey._(key: 'userIsStaff', type: bool, defaultValue: false);


//---------------------------------------------------------------------------
//
//  Public helper methods
//
//---------------------------------------------------------------------------

/// Gets a persisted SharedPreference value asynchrounously and returns it.
/// 
/// The return value has a dynamic type so you need to know the type of the
/// result beforehand.
Future<dynamic> getPreferenceValue(PreferenceKey key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final result = prefs.get(key.key);

  if (result == null) {
    dev.log("Shared preference '${key.key}' was null. Returning default value: '${key.defaultValue}'.");
    return key.defaultValue;
  } else {
    return result;
  }
}

/// Persists the given [value] for the given SharedPreferences [key].
Future<bool> putPreferenceValue(PreferenceKey key, dynamic value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  switch(key.type) {
    case bool:
      return prefs.setBool(key.key, value);

    case int:
      return prefs.setInt(key.key, value);

    case double:
      return prefs.setDouble(key.key, value);

    case String:
      return prefs.setString(key.key, value);

    default:
      // Actually not needed since PreferencyKey cannot be instantiated
      // by the user. Just there for compatibility.
      return false;
  }
}