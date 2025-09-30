import 'package:flutter/material.dart';

class LevelNotifier extends ChangeNotifier {
  bool _isBeginnerCompleted = false;
  bool _isIntermediateCompleted = false;

  bool get isBeginnerCompleted => _isBeginnerCompleted;
  bool get isIntermediateCompleted => _isIntermediateCompleted;

  void markBeginnerCompleted() {
    if (!_isBeginnerCompleted) {
      _isBeginnerCompleted = true;
      notifyListeners();
    }
  }

  void markIntermediateCompleted() {
    if (!_isIntermediateCompleted) {
      _isIntermediateCompleted = true;
      notifyListeners();
    }
  }
}
