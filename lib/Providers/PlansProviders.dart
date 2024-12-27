import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/Constrants/Colors.dart';

class PlanProvider with ChangeNotifier {
  String _selectedPlan = '';
  Color _backgroundColor = Colors.white;
  Color _textColor = AppColors.textColor;
  Color _textColor1 = Colors.black.withOpacity(0.6);
  Color _textColor2 = Colors.grey;

  String get selectedPlan => _selectedPlan;
  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  Color get textColor1 => _textColor1;
  Color get textColorPrice => _textColor2;

  void updatePlan(String plan, Color backgroundColor, Color textColor, Color textColor1, Color textColor2) {
    _selectedPlan = plan;
    _backgroundColor = backgroundColor;
    _textColor = textColor;
    _textColor1 = _textColor1;
    _textColor2 = _textColor2;
    notifyListeners();
  }

  void toggleBackgroundColor() {
    _backgroundColor = _backgroundColor == Colors.black ? Colors.white : Colors.black;
    _textColor = _textColor == Colors.white ? AppColors.textColor : Colors.white;
    _textColor1 = _textColor1 == Colors.white.withOpacity(0.6) ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.6);
    _textColor2 = _textColor2 == Colors.white54 ? Colors.grey : Colors.white54;
    notifyListeners();
  }
}
