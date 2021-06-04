import 'package:flutter/widgets.dart';

class UserCarProvider extends ChangeNotifier {

  //Estado privado del coche
  int _carId = -1;
  String _carModel = "";

  get carId => _carId;

  //Cambiamos el id del coche seleccionado
  set carId(int id) {
    _carId = id;
    // Esta llamada dice a los widgets que están escuchando este modelo que se reconstruyan.
    notifyListeners();
  }

  get carModel => _carModel;

  //Cambiamos el modelo del coche seleccionado
  set carModel(String carModel) {
    _carModel = carModel;
    // Esta llamada dice a los widgets que están escuchando este modelo que se reconstruyan.
    notifyListeners();
  }
}
