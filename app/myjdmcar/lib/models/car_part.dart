import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/models/car_part_brand.dart';
import 'package:myjdmcar/models/car_part_type.dart';

class CarPartModel {
  final int id;
  final String reference;
  final String description;
  final String image;
  final CarPartBrandModel carPartBrand;
  final CarModelModel carModel;
  final CarPartTypeModel carPartType;

  CarPartModel(
      {this.id,
      this.reference,
      this.description,
      this.image,
      this.carPartBrand,
      this.carModel,
      this.carPartType});

  CarPartModel.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.reference = parsedJson['reference'],
        this.description = parsedJson['description'],
        this.image = parsedJson['image'],
        this.carPartBrand =
            CarPartBrandModel.fromJson(parsedJson['carPartBrand']),
        this.carModel = CarModelModel.fromJson(parsedJson['carModel']),
        this.carPartType = CarPartTypeModel.fromJson(parsedJson['carPartType']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'reference': reference,
        'description': description,
        'image': image,
        'carPartBrand': carPartBrand.toJson(),
        'carModel': carModel.toJson(),
        'carPartType': carPartType.toJson()
      };
}
