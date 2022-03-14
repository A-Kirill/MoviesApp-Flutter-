import 'package:flutter/material.dart';

import 'storage_manager.dart';

class ThemeNotifier with ChangeNotifier {

  var _darkMode = false;

  bool get darkMode => _darkMode;

  void initializeApp() {
    var pref = StorageManager();
    pref.getThemeIsDark().then((value) {
      _darkMode = value;
      notifyListeners();
    });
  }

  void setDarkMode() {
    _darkMode = true;
    saveMode();
    notifyListeners();
  }

  void setLightMode() {
    _darkMode = false;
    saveMode();
    notifyListeners();
  }

  void saveMode() {
    var pref = StorageManager();
    pref.saveTheme(_darkMode);
  }

}
