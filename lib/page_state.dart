import 'package:flutter/material.dart';

enum PageState { configure, flash, select, result }

// Used to track the current state of the homepage
class CurrentPageState extends ChangeNotifier {
  PageState _curState = PageState.configure;

  PageState get get => _curState;

  void set(PageState state) {
    _curState = state;
    notifyListeners();
  }
}