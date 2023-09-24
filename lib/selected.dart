import 'package:flutter/material.dart';

// Used to track the selected assets by the user
class Selected extends ChangeNotifier {
  List<String> _selected = [];
  
  List<String> get get => List.unmodifiable(_selected);

  void add(String str) {
    _selected.add(str);
    notifyListeners();
  }

  void reset() {
    _selected = [];
  }
}
