
import 'package:flutter/material.dart';

class CarPartsFilterProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
    print("Index " + index.toString());
  }

}
