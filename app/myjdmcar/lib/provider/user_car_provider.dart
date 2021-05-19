import 'package:flutter/widgets.dart';

class UserCarProvider extends ChangeNotifier {
  //TODO - Shared Preference

  int _carId = 1;
  String _carModel = "";

  get carId => _carId;

  set carId(int id) {
    _carId = id;
    notifyListeners();
  }

  get carModel => _carModel;

  set carModel(String carModel) {
    _carModel = carModel;
    notifyListeners();
  }
}
