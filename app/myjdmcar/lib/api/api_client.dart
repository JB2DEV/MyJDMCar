import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/models/car.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/models/car_part.dart';
import 'package:myjdmcar/models/car_part_brand.dart';
import 'package:myjdmcar/models/car_part_type.dart';
import 'package:myjdmcar/models/user.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';
import 'api_return_codes.dart';
import 'api_routes.dart';

class ApiClient {
  static final _client = ApiClient._internal();
  final _http = HttpClient();

  ApiClient._internal();

  final httpHead = 'http://';
  final baseUrl = '10.0.2.2';

  final authUrl = "/auth/";
  final gettersUrl = "/getters/";
  final imagesUrl = "/img/";
  final carPartsUrl = "piezas";
  final carPartsBrandsUrl = "marcas_piezas/";

  final carModelsUrl = "modelos_coches/";

  factory ApiClient() => _client;

  Future<UserModel> mySignIn() async {
    var test = '/auth/login.php';
    Map<String, dynamic> toJson() => {'user': variable1, 'pass': variable2};
    final response = await http.post(Uri.http(baseUrl, test), body: toJson());
    //final decodedJson = await json.decode(response.body);
    Map<String, dynamic> decodedJson = jsonDecode(response.body);
    print(decodedJson);
    if (decodedJson['response'] == 'success') {
      UserModel actualUser =
          UserModel.fromJson(jsonDecode(decodedJson['data']));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', actualUser.id);
      await prefs.setString('email', actualUser.userName);
      await prefs.setString('accessToken', actualUser.accessToken);
      await prefs.setString('userName', actualUser.userName);
//      print(actualUser.toJson());

      return actualUser;
    } else {
      throw Exception("Login fail");
    }
  }

  Future<UserModel> mySignUp() async {
    var test = '/auth/signup.php';
    Map<String, dynamic> toJson() =>
        {'user': variable3, 'email': variable1, 'pass': variable2};
    final response = await http.post(Uri.http(baseUrl, test), body: toJson());
    final decodedJson = await json.decode(response.body);
    print(decodedJson);
    if (decodedJson['response'] == 'insertado') {
      return UserModel.fromJson(jsonDecode(decodedJson['data']));
    } else {
      throw Exception("Signup fail");
    }
  }

  Future<UserModel> getLoggedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("userId") ?? null;
    String email = prefs.getString("email" ?? null);
    String userName = prefs.getString("userName" ?? null);
    String token = prefs.getString("accessToken" ?? null);
    return UserModel(
        id: userId, email: email, userName: userName, accessToken: token);
  }

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

  Future listCarPartDynamic(bool carPartBrandSelected, bool carPartSelected,
      BuildContext context, int idBrand) async {
    if (!carPartBrandSelected) return await getCarPartsBrands(context);
    if (!carPartSelected)
      return await getCarPartsListFilteredByBrand(context, idBrand);
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
    print(data.toString());
    CarModelModel car = CarModelModel.fromJson(jsonDecode(data['data']));
    //print(car.toJson());
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

  Future<List<CarPartBrandModel>> getCarPartsBrands(
      BuildContext context) async {
    /*final result =
        await rootBundle.loadString('assets/data/car_parts_brands.json');
    print(result);*/
    int carId =
        await Provider.of<UserCarProvider>(context, listen: false).carId;

    Map<String, dynamic> toJson() => {"id": carId.toString()};
    final response = await http.post(
        Uri.http(baseUrl, "/getters/getCarPartsBrands.php"),
        body: toJson());

    List<dynamic> data = json.decode(response.body);
    /*  //CHECK DATATYPE
    print(data.runtimeType.toString() + " " + data.toString());
    data.forEach((element) {
      print(element.runtimeType.toString() + " " + element.toString());
    });*/

    List<CarPartBrandModel> carPartsBrandsList =
        data.map((i) => CarPartBrandModel.fromJson(json.decode(i))).toList();

    return carPartsBrandsList;
  }

  Future<List<CarPartTypeModel>> getCarPartsTypeData() async {
    final response =
        await http.post(Uri.http(baseUrl, "/getters/getCarPartsTypeList.php"));

    List<dynamic> data = json.decode(response.body);
    /*  //CHECK DATATYPE
    print(data.runtimeType.toString() + " " + data.toString());
    data.forEach((element) {
      print(element.runtimeType.toString() + " " + element.toString());
    });*/

    List<CarPartTypeModel> carPartsTypeList =
        data.map((i) => CarPartTypeModel.fromJson(json.decode(i))).toList();

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
    print(jsonDecode(decodedJson['data']));
    CarModel car = CarModel.fromJson(jsonDecode(decodedJson['data']));

    return car;
  }

  Future<List<CarPartModel>> getCarPartsListFilteredByBrand(
      BuildContext context, int idBrand) async {
    int carId =
        await Provider.of<UserCarProvider>(context, listen: false).carId;

    Map<String, dynamic> toJson() =>
        {"id": carId.toString(), "marca": idBrand.toString()};
    final response = await http.post(
        Uri.http(baseUrl, "/getters/getCarPartsListFilteredByBrand.php"),
        body: toJson());

    List<dynamic> data = json.decode(response.body);
    /*  //CHECK DATATYPE
    print(data.runtimeType.toString() + " " + data.toString());
    data.forEach((element) {
      print(element.runtimeType.toString() + " " + element.toString());
    });*/

    List<CarPartModel> carPartList =
        data.map((i) => CarPartModel.fromJson(json.decode(i))).toList();

    return carPartList;
  }

  Future<bool> addCarPart(BuildContext context, int idPieza) async {
    int carId =
        await Provider.of<UserCarProvider>(context, listen: false).carId;

    Map<String, dynamic> toJson() =>
        {"coche": carId.toString(), "pieza": idPieza.toString()};
    final response = await http
        .post(Uri.http(baseUrl, "/setters/addCarPart.php"), body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    print(data['insert']);
    return data['insert'];
  }

  Future<bool> deleteCarPartFromCar(BuildContext context, int idPieza) async {
    int carId =
        await Provider.of<UserCarProvider>(context, listen: false).carId;

    Map<String, dynamic> toJson() =>
        {"coche": carId.toString(), "pieza": idPieza.toString()};
    final response = await http.post(
        Uri.http(baseUrl, "/updates/deleteCarPartFromCar.php"),
        body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    print(data['delete']);
    return data['delete'];
  }

  Future<bool> addCar(BuildContext context, String modelo) async {
    int idUser = await getActualUserId();
    Map<String, dynamic> toJson() =>
        {"modelo": modelo, "user": idUser.toString()};
    final response = await http.post(Uri.http(baseUrl, "/setters/addCar.php"),
        body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    if (data['insert']) {
      CarModel car = CarModel.fromJson(data['car']);
      Provider.of<UserCarProvider>(context, listen: false).carId = car.id;
      Provider.of<UserCarProvider>(context, listen: false).carModel =
          car.carBrand.name + ' ' + car.carModel.name;
    }
    return data['insert'];
  }

  Future<bool> deleteCar(int idCoche) async {
    Map<String, dynamic> toJson() => {
          "coche": idCoche.toString(),
        };
    final response = await http
        .post(Uri.http(baseUrl, "/updates/deleteCar.php"), body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    print(data['delete']);
    return data['delete'];
  }

  Future<bool> logout() async {
    int userId = await getActualUserId() as int;
    Map<String, dynamic> toJson() => {"id": userId.toString()};

    final response =
        await http.post(Uri.http(baseUrl, "/auth/logout.php"), body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    print(data['logout']);
    return data['logout'];
  }

  Future<bool> changePassword(String pwd) async {
    int userId = await getActualUserId() as int;
    Map<String, dynamic> toJson() => {"id": userId.toString(), "pwd": pwd};

    final response =
        await http.post(Uri.http(baseUrl, "//logout.php"), body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    print(data['logout']);
    return data['logout'];
  }
}
