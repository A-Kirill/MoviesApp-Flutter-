import 'dart:ui';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager implements ITranslatePreferences {
  static const String _localeKey = 'selected_locale';
  static const String _themeKey = 'theme';


  @override
  Future<Locale> getPreferredLocale() async {
    final preferences = await SharedPreferences.getInstance();
    var locale = preferences.getString(_localeKey);
    return localeFromString(locale!);
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_localeKey, localeToString(locale));
  }


  Future saveTheme(bool dark) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool(_themeKey, dark);
  }

  Future<bool> getThemeIsDark() async {
    final preferences = await SharedPreferences.getInstance();
    var locale = preferences.getBool(_themeKey);

    return locale ?? false;
  }
}