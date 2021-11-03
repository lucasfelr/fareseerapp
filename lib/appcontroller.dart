import 'package:flutter/cupertino.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  int creditos = 10;

  bool isDartTheme = false;
  changeTheme() {
    isDartTheme = !isDartTheme;
    notifyListeners();
  }
}
