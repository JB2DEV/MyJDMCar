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
      : this.id = parsedJson['id'] as int ?? null,
        this.user =
            parsedJson.keys.contains('user') && parsedJson['user'] != null
                ? UserModel.fromJson(parsedJson['user'])
                : null,
        this.carBrand = parsedJson.keys.contains('carBrand') &&
                parsedJson['carBrand'] != null
            ? CarBrandModel.fromJson(parsedJson['carBrand'])
            : null,
        this.carModel = parsedJson.keys.contains('carModel') &&
                parsedJson['carModel'] != null
            ? CarModelModel.fromJson(parsedJson['carModel'])
            : null,
        this.carParts =
            getCarParts(parsedJson) == null ? [] : getCarParts(parsedJson);

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'user': user.toJson() ?? null,
        'carBrand': carBrand.toJson() ?? null,
        'carModel': carModel.toJson() ?? null,
        'carParts': jsonEncode(carParts) ?? null
      };

  static getCarParts(Map<String, dynamic> parsedJson) {
    var list = parsedJson['carParts'] as List;
    if (list == null) return null;
    List<CarPartModel> carPartList =
        list.map((i) => CarPartModel.fromJson(i)).toList();
    return carPartList;
  }
}
