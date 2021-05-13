import 'dart:convert';

import 'package:myjdmcar/models/car_brand.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:myjdmcar/models/user.dart';

class CarModel {
  final int id;
  final UserModel user;
  final CarBrandModel carBrand;
  final CarModelModel carModel;
  final List<CarPartModel> carParts;

  CarModel({this.id, this.user, this.carBrand, this.carModel, this.carParts});

  CarModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.user = UserModel.fromJson(parsedJson['user']),
        this.carBrand = CarBrandModel.fromJson(parsedJson['carBrand']),
        this.carModel = CarModelModel.fromJson(parsedJson['carModel']),
        this.carParts = getCarParts(parsedJson);

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'carBrand': carBrand.toJson(),
        'carModel': carModel.toJson(),
        'carParts' : jsonEncode(carParts)
      };

  static getCarParts(Map<String, dynamic> parsedJson) {
    var list = parsedJson['carParts'] as List;
    List<CarPartModel> carPartList =
        list.map((i) => CarPartModel.fromJson(i)).toList();
    if (carPartList == null) carPartList = [];
    return carPartList;
  }
}
