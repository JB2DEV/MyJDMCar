import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:myjdmcar/models/car_part_brand.dart';
import 'package:myjdmcar/models/car_part_type.dart';

class ApiClientTest {
  ApiClientTest();

  Future addCarPartDynamic(bool carPartBrandSelected, bool carPartSelected) async {
    if (!carPartBrandSelected) return await getCarPartsBrands();
    if(!carPartSelected) return await getData("Todos");
    return null;
  }

  Future<CarModelModel> getUserCarModelData(int carId) async {
    final result = await rootBundle
        .loadString("assets/data/user_car_model_" + carId.toString() + ".json");
    final data = json.decode(result);
    print(data);
    return CarModelModel.fromJson(data);
  }

  Future<List<CarPartModel>> getCarPartData(int id) async {
    final result = await rootBundle
        .loadString('assets/data/car_part_' + id.toString() + '.json');
    final data = json.decode(result);
    print(data);
    List<CarPartModel> carPartsTypeList;
    carPartsTypeList = (data['data'] as List)
        .map((i) => new CarPartModel.fromJson(i))
        .toList();

    return carPartsTypeList;
  }

  Future<List<CarPartModel>> getData(String tipo) async {
    final result = await rootBundle.loadString('assets/data/' + tipo + '.json');
    final data = json.decode(result);
    print(data);
    List<CarPartModel> carPartsTypeList;
    carPartsTypeList = (data['data'] as List)
        .map((i) => new CarPartModel.fromJson(i))
        .toList();

    return carPartsTypeList;
  }

  Future<List<CarPartBrandModel>> getCarPartsBrands() async {
    final result =
        await rootBundle.loadString('assets/data/car_parts_brands.json');
    print(result);
    final data = json.decode(result);
    print(data);
    List<CarPartBrandModel> carPartsBrandsList;
    carPartsBrandsList = (data['data'] as List)
        .map((i) => new CarPartBrandModel.fromJson(i))
        .toList();

    return carPartsBrandsList;
  }

  Future<List<CarPartTypeModel>> getCarPartsTypeData() async {
    final result =
        await rootBundle.loadString('assets/data/car_parts_type.json');
    print(result);
    final data = json.decode(result);
    print(data);
    List<CarPartTypeModel> carPartsTypeList;
    carPartsTypeList = (data['data'] as List)
        .map((i) => new CarPartTypeModel.fromJson(i))
        .toList();

    return carPartsTypeList;
  }
}
