
import 'package:flutter/material.dart';

class CarPartsFilterProvider with ChangeNotifier {
  int _currentIndex = 0;
  String _carPartType = "Todos";


  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
    print("Index " + index.toString());
  }

  get carPartType => _carPartType;

  set carPartType(String carPartType) {
    _carPartType = carPartType;
    notifyListeners();
    print("Index " + carPartType);
  }
}
