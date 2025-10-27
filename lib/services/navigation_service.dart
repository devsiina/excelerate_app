import 'package:flutter/material.dart';

class NavigationService extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}

// Extension methods for navigation
extension NavigationExtension on BuildContext {
  void pushAndRemoveUntil(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void pushReplacement(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void safePop() {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }
}