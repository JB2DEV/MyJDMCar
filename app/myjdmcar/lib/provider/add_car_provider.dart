import 'package:flutter/material.dart';

class AddCarProvider extends ChangeNotifier {
  String _currentBrand = "None";
  String _currentModel = "None";

  get currentBrand => _currentBrand;

  set currentBrand(String currentBrand) {
    _currentBrand = currentBrand;
    notifyListeners();
  }

  get currentModel => _currentModel;

  set currentModel(String currentModel) {
    _currentModel = currentModel;
    notifyListeners();
  }
}
