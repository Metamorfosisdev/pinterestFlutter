import 'package:flutter/material.dart';

class ShowMenuProvider extends ChangeNotifier {
  bool _isShowMenu = true;

  Color _selectedColor = Colors.blue;
  Color _backgroundColor = Colors.grey;

  bool get isShowMenu => _isShowMenu;
  set isShowMenu(bool value) {
    _isShowMenu = value;
    notifyListeners();
  }

  Color get selectedColor => _selectedColor;
  set selectedColor(Color value) {
    _selectedColor = value;
  }

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color value) {
    _backgroundColor = value;
  }
}
