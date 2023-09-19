import 'package:flutter/material.dart';

class _Selected {
  List<String> selected = [];

  void add(String str) => selected.add(str);

  List<String> get get => selected;
}

class SelectedProvider extends ChangeNotifier {
  final _Selected _selected = _Selected();

  List<String> get get => _selected.get;

  void add(String str) {
    _selected.add(str);
    notifyListeners();
  }
}
