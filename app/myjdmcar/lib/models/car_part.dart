import 'dart:convert';

import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/models/car_part_brand.dart';
import 'package:myjdmcar/models/car_part_type.dart';

class CarPartModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String url;
  final CarPartBrandModel carPartBrand;
  final CarPartTypeModel carPartType;
  final List<CarModelModel> carModels;

  CarPartModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.url,
    this.carPartBrand,
    this.carPartType,
    this.carModels,
  });

  CarPartModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] as int ?? null,
        this.name = parsedJson['name'] ?? null,
        this.description = parsedJson['description'] ?? null,
        this.image = parsedJson['image'] ?? null,
        this.url = parsedJson['url'] ?? null,
        this.carPartBrand = parsedJson.keys.contains('carPartBrand') &&
                parsedJson['carPartBrand'] != null
            ? CarPartBrandModel.fromJson(parsedJson['carPartBrand'])
            : null,
        this.carPartType = parsedJson.keys.contains('carPartType') &&
                parsedJson['carPartType'] != null
            ? CarPartTypeModel.fromJson(parsedJson['carPartType'])
            : null,
        this.carModels =
            getCarModels(parsedJson) == null ? [] : getCarModels(parsedJson);

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'name': name ?? null,
        'description': description ?? null,
        'image': image ?? null,
        'url': url ?? null,
        'carPartBrand': carPartBrand.toJson() ?? null,
        'carPartType': carPartType.toJson() ?? null,
        'carModels': jsonEncode(carModels) ?? null
      };

  static getCarModels(Map<String, dynamic> parsedJson) {
    var list = parsedJson['carModels'] as List;
    if (list == null) return null;
    List<CarModelModel> carModelsList =
        list.map((i) => CarModelModel.fromJson(i)).toList();
    return carModelsList;
  }
}
