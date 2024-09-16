import 'package:flutter/material.dart';
import '../pages/settings.dart';
import '../pages/task_lists.dart';

class BottomNavSelect extends ChangeNotifier {

  int selectedIndex = 0;
  final List<Widget> _pages = [
    TaskLists( ),
    Settings(),
  ];

  Widget getSelectedPage() {
    return _pages[selectedIndex];
  }

  void selectTap(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }
}
