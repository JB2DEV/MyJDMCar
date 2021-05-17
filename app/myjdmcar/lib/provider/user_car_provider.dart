import 'package:flutter/widgets.dart';

class UserCarProvider extends ChangeNotifier {
    //TODO - Shared Preference

  int _carId = 1111;
  String _carModel = "Nissan Silvia s14";

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
