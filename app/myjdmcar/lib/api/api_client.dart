import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/models/car.dart';
import 'package:myjdmcar/models/car_brand.dart';
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

  Future<UserModel> mySignIn(String email, String password) async {
    var test = '/auth/login.php';
    Map<String, dynamic> toJson() => {'user': email, 'pass': password};
    final response = await http.post(Uri.http(baseUrl, test), body: toJson());
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
      await prefs.setString('expDate', actualUser.expDate);
      print(actualUser.toJson());

      return actualUser;
    } else {
      throw Exception("Login fail");
    }
  }

  Future<UserModel> mySignUp(
      String username, String email, String password) async {
    var test = '/auth/signup.php';
    Map<String, dynamic> toJson() =>
        {'user': username, 'email': email, 'pass': password};
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
    String expDate = prefs.getString("expDate" ?? null);
    return UserModel(
        id: userId,
        email: email,
        userName: userName,
        accessToken: token,
        expDate: expDate);
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
    Map<String, dynamic> toJson() => {'id': carId.toString()};
    final response = await http.post(
        Uri.http(baseUrl, "/getters/getUserCarModelData.php"),
        body: toJson());
    final data = json.decode(response.body);
    print("data");
    print(data.toString());
    CarModelModel car = CarModelModel.fromJson(jsonDecode(data['data']));
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
    Map<String, dynamic> toJson() =>
        {"typeId": typeId.toString(), "id": carId.toString()};
    final response = await http
        .post(Uri.http(baseUrl, "/getters/getCarPartData.php"), body: toJson());
    List<dynamic> data = json.decode(response.body);
    List<CarPartModel> carPartsList =
        data.map((i) => CarPartModel.fromJson(json.decode(i))).toList();
    print(carPartsList.toString());
    return carPartsList;
  }

  Future<List<CarPartBrandModel>> getCarPartsBrands(
      BuildContext context) async {
    int carId =
        await Provider.of<UserCarProvider>(context, listen: false).carId;

    Map<String, dynamic> toJson() => {"id": carId.toString()};
    final response = await http.post(
        Uri.http(baseUrl, "/getters/getCarPartsBrands.php"),
        body: toJson());

    List<dynamic> data = json.decode(response.body);

    List<CarPartBrandModel> carPartsBrandsList =
        data.map((i) => CarPartBrandModel.fromJson(json.decode(i))).toList();

    return carPartsBrandsList;
  }

  Future<List<CarPartTypeModel>> getCarPartsTypeData() async {
    final response =
        await http.post(Uri.http(baseUrl, "/getters/getCarPartsTypeList.php"));

    List<dynamic> data = json.decode(response.body);

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
    Map<String, dynamic> decodedJson = jsonDecode(response.body);
    if (decodedJson == null) {
      return null;
    } else {
      CarModel car = CarModel.fromJson(jsonDecode(decodedJson['data']));
      return car;
    }
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

    List<CarPartModel> carPartList =
        data.map((i) => CarPartModel.fromJson(json.decode(i))).toList();

    return carPartList;
  }

  Future<List<CarBrandModel>> getCarBrands() async {
    final response =
        await http.post(Uri.http(baseUrl, "/getters/getCarBrands.php"));

    List<dynamic> data = json.decode(response.body);

    List<CarBrandModel> carBrandsList =
        data.map((i) => CarBrandModel.fromJson(json.decode(i))).toList();

    return carBrandsList;
  }

  Future<List<CarModelModel>> getCarModelsByBrand(String marca) async {
    print("Marca: " + marca);
    Map<String, dynamic> toJson() => {"marca": marca};
    final response = await http.post(
        Uri.http(baseUrl, "/getters/getCarModelsByBrand.php"),
        body: toJson());

    List<dynamic> data = json.decode(response.body);

    List<CarModelModel> carModelsList =
        data.map((i) => CarModelModel.fromJson(json.decode(i))).toList();

    return carModelsList;
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
      print(data['car']);
      CarModel car = CarModel.fromJson(data['car']);
      print(car.toJson().toString());
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

  Future<bool> changePassword(String actual, String pwd) async {
    int userId = await getActualUserId() as int;
    Map<String, dynamic> toJson() =>
        {"id": userId.toString(), "pwd": pwd, "actual": actual};

    final response = await http.post(Uri.http(baseUrl, "/auth/changePwd.php"),
        body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    print(data['changed']);
    return data['changed'];
  }

  Future<bool> changeUsername(String username) async {
    int userId = await getActualUserId() as int;
    Map<String, dynamic> toJson() =>
        {"id": userId.toString(), "user": username};

    final response = await http
        .post(Uri.http(baseUrl, "/auth/changeUsername.php"), body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    if (data['changed']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', username);
    }

    return data['changed'];
  }

  Future<bool> recoverPassword(String mail) async {
    Map<String, dynamic> toJson() => {"mail": mail};

    final response = await http
        .post(Uri.http(baseUrl, "/auth/recoverPassword.php"), body: toJson());

    Map<String, dynamic> data = json.decode(json.decode(response.body)['data']);
    return data['changed'];
  }

  Future requestMissing(String marca, String modelo, String info) async {
    int userId = await getActualUserId() as int;

    Map<String, dynamic> toJson() => {
          "id": userId.toString(),
          "marca": marca,
          "modelo": modelo,
          "info": info == null ? 'null' : info
        };
    await http.post(Uri.http(baseUrl, "/request/request.php"), body: toJson());
  }
}
