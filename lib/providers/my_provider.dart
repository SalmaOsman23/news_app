import 'package:flutter/material.dart';

import '../preference/my_preference.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  Color appBarColor = Colors.green;

  MyProvider() {
    initstate();
  }

  initstate() async {
    String? mode = MyPreference.getMode();
    if (mode == "dark") {
      setCurrentTheme(ThemeMode.dark);
    } else {
      setCurrentTheme(ThemeMode.light);
    }
    notifyListeners();
  }

  void changeTabColor(Color newColor) {
    appBarColor = newColor;
    notifyListeners();
  }

  void setCurrentTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    if (newTheme == "dark") {
      MyPreference.saveMode("dark");
    } else {
      MyPreference.saveMode("light");
    }
    notifyListeners();
  }

  bool isDarkMode() => currentTheme == ThemeMode.dark;
}
