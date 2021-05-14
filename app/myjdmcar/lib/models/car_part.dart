import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/models/car_part_brand.dart';
import 'package:myjdmcar/models/car_part_type.dart';

class CarPartModel {
  final int id;
  final String reference;
  final String name;
  final String description;
  final String image;
  final CarPartBrandModel carPartBrand;
  final CarModelModel carModel;
  final CarPartTypeModel carPartType;

  CarPartModel(
      {this.id,
      this.reference,
      this.name,
      this.description,
      this.image,
      this.carPartBrand,
      this.carModel,
      this.carPartType});

  CarPartModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'] ?? null,
        this.reference = parsedJson['reference'] ?? null,
        this.name = parsedJson['name'] ?? null,
        this.description = parsedJson['description'] ?? null,
        this.image = parsedJson['image'] ?? null,
        this.carPartBrand = parsedJson.keys.contains('carPartBrand') &&
                parsedJson['carPartBrand'] != null
            ? CarPartBrandModel.fromJson(parsedJson['carPartBrand'])
            : null,
        this.carModel = parsedJson.keys.contains('carModel') &&
                parsedJson['carModel'] != null
            ? CarModelModel.fromJson(parsedJson['carModel'])
            : null,
        this.carPartType = parsedJson.keys.contains('carPartType') &&
                parsedJson['carPartType'] != null
            ? CarPartTypeModel.fromJson(parsedJson['carPartType'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id ?? null,
        'reference': reference ?? null,
        'name': name ?? null,
        'description': description ?? null,
        'image': image ?? null,
        'carPartBrand': carPartBrand.toJson() ?? null,
        'carModel': carModel.toJson() ?? null,
        'carPartType': carPartType.toJson() ?? null
      };
}
