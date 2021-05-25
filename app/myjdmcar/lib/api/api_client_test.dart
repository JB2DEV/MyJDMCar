import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:myjdmcar/models/car.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:myjdmcar/models/car_part_brand.dart';
import 'package:myjdmcar/models/car_part_type.dart';
import 'package:http/http.dart' as http;
import 'package:myjdmcar/provider/car_parts_type_provider.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClientTest {
  ApiClientTest();
  final baseUrl = '10.0.2.2';

  Future getActualUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString("userName" ?? null);
    return userName;
  }

  Future getActualUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("userId") ?? null;

    return userId;
  }

  Future addCarPartDynamic(bool carPartBrandSelected, bool carPartSelected,
      BuildContext context) async {
    if (!carPartBrandSelected) return await getCarPartsBrands();
    if (!carPartSelected)
      return await getData(
          0,
          Provider.of<UserCarProvider>(context, listen: false).carId);
    return null;
  }

  Future<CarModelModel> getUserCarModelData(int carId) async {
    //final result = await rootBundle.loadString("assets/data/user_car_model_" + carId.toString() + ".json");

    Map<String, dynamic> toJson() => {'id': carId.toString()};
    final response = await http.post(
        Uri.http(baseUrl, "/getters/getUserCarModelData.php"),
        body: toJson());
    final data = json.decode(response.body);
    print("data");
    CarModelModel car = CarModelModel.fromJson(data);
    print(car.toJson());
    return car;
  }

  Future<List<CarModel>> getUserCarsData(int userId) async {
    Map<String, dynamic> toJson() => {"id": userId.toString()};
    final response = await http.post(
        Uri.http(baseUrl, "/getters/getUserCarsData.php"),
        body: toJson());

    List<dynamic> data = json.decode(response.body);
    /*//CHECK DATATYPE
    print(data.runtimeType.toString() + " " + data.toString());
    data.forEach((element) {
      print(element.runtimeType.toString() + " " + element.toString());
    });*/

    List<CarModel> userCarsList =
        data.map((i) => CarModel.fromJson(json.decode(i))).toList();
    return userCarsList;
  }

  Future<List<CarPartModel>> getData(int typeId, int carId) async {
    /*final result = await rootBundle
        .loadString('assets/data/' + typeId.toString() + '.json');
    final data = json.decode(result);
    print(data);*/

    Map<String, dynamic> toJson() =>
        {"typeId": typeId.toString(), "id": carId.toString()};
    final response = await http
        .post(Uri.http(baseUrl, "/getters/getCarPartData.php"), body: toJson());
    List<dynamic> data = json.decode(response.body);
    /*//CHECK DATATYPE
    print(data.runtimeType.toString() + " " + data.toString());
    data.forEach((element) {
      print(element.runtimeType.toString() + " " + element.toString());
    });*/

    List<CarPartModel> carPartsList =
        data.map((i) => CarPartModel.fromJson(json.decode(i))).toList();
    print(carPartsList.toString());
    return carPartsList;
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
    //print(result);
    final data = json.decode(result);
    // print(data);
    List<CarPartTypeModel> carPartsTypeList;
    carPartsTypeList = (data['data'] as List)
        .map((i) => new CarPartTypeModel.fromJson(i))
        .toList();

    return carPartsTypeList;
  }

  Future getFirstCarData() async {
    int userId = await getActualUserId() as int;
    Map<String, dynamic> toJson() => {"id": userId.toString()};

    final response = await http.post(
        Uri.http(baseUrl, "/getters/getUserFirstCarData.php"),
        body: toJson());
    //final decodedJson = await json.decode(response.body);
    Map<String, dynamic> decodedJson = jsonDecode(response.body);
    //print(decodedJson);
    CarModel car = CarModel.fromJson(jsonDecode(decodedJson['data']));

    return car;
  }
}
