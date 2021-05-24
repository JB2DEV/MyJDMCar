import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/models/user.dart';
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

/*
  Future<User> signUp(String email, String password) async {
    Map<String, dynamic> params = {
      "email": email,
      "password": password,
    };

    var url = Uri.http(baseUrl, '$api${routes["signup"]}');

    var response = await apiPOSTRequest(url, jsonEncode(params));
    var rc = response["rc"];

    switch (rc) {
      case 0:
        final prefs = await SharedPreferences.getInstance();
        User user = User.fromJson(response["data"]["user"]);

        prefs.setString('user', json.encode(response["data"]["user"]));
        prefs.setString('accessToken', response["data"]["access_token"]);

        /*print("accessToken");
        print(response['data']['access_token']);*/

        //user.accessToken = response["data"]["access_token"];

        return user;
        break;
      default:
        // KO
        throw ApiException(getRCMessage(rc), rc);
        break;
    }
  }

  Future<User> signIn(String email, String password) async {
    Map<String, dynamic> params = {
      "email": email,
      "password": password,
    };

    var url = Uri.http(baseUrl, '$api${routes["login"]}');

    var response = await apiPOSTRequest(url, jsonEncode(params));
    var rc = response["rc"];

    switch (rc) {
      case 0:
        // LOGIN OK
        final prefs = await SharedPreferences.getInstance();
        User user = User.fromJson(response["data"]["user"]);

        prefs.setString('user', json.encode(response["data"]["user"]));
        prefs.setString('accessToken', response["data"]["access_token"]);

        return user;
        break;
      default:
        // ERROR
        throw ApiException(getRCMessage(rc), rc);
        break;
    }
  }

  Future<dynamic> forget(String email) async {
    Map<String, dynamic> params = {"email": email};

    var url = Uri.http(baseUrl, '$api${routes["forget"]}');

    var response = await apiPOSTRequest(url, jsonEncode(params));
    var rc = response["rc"];

    switch (rc) {
      case 0:
        // OK
        return response["data"];
        break;
      default:
        // ERROR
        throw ApiException(getRCMessage(rc), rc);
        break;
    }
  }

  Future<dynamic> editUser(String email, String accessToken) async {
    Map<String, dynamic> params = {
      "email": email,
    };

    var url = Uri.http(baseUrl, '$api$authUrl${routes["edit"]}');
    print(url);

    var response =
        await apiGETAuthRequest(url, jsonEncode(params), accessToken);
    var rc = response["rc"];

    switch (rc) {
      case 0:
        final prefs = await SharedPreferences.getInstance();
        User user = User.fromJson(response["data"]);

        prefs.setString('user', json.encode(response["data"]));

        return user;
      default:
        throw ApiException(getRCMessage(rc), rc);
        break;
    }
  }

  Future<dynamic> changePassword(String password, String accessToken) async {
    Map<String, dynamic> params = {
      "password": password,
    };

    var url = Uri.http(baseUrl, '$api$authUrl${routes["changePassword"]}');

    var response =
        await apiPOSTAuthRequest(url, jsonEncode(params), accessToken);
    var rc = response["rc"];

    switch (rc) {
      case 0:
        return response["data"];
      default:
        throw ApiException(getRCMessage(rc), rc);
        break;
    }
  }

  Future<dynamic> apiGETRequest(
      Uri uri, Map<String, String> queryParams) async {
    final response =
        await http.get(uri, headers: {HttpHeaders.authorizationHeader: null});
    final decodedJson = await json.decode(response.body);
    return response;
  }

  ///
  Future<dynamic> apiGETAuthRequest(
      Uri uri, String params, String accessToken) async {
    try {
      print("URL: " + uri.toString());
      print("Params: " + params.toString());

      HttpClient http = HttpClient();
      HttpClientRequest request = await http.getUrl(uri);

      // Indiquem headers
      request.headers
          .set(HttpHeaders.authorizationHeader, 'Bearer $accessToken');
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");

      // Afegim paràmetres
      if (params != null) {
        request.headers.contentLength = utf8.encode(params).length;
        request.add(utf8.encode(params));
      }

      var response = await request.close();

      print("RESPONSE: " + response.statusCode.toString());
      print("RESPONSE reason phrase: " + response.reasonPhrase);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = await response.transform(utf8.decoder).join();
        print(decodedResponse);
        return json.decode(decodedResponse);
      } else if (response.statusCode >= 400 && response.statusCode <= 599) {
        throw ApiException("Client error", response.statusCode);
      }
    } catch (e) {
      print("ELOL " + e.toString());
      print(e);
      throw ApiException(getRCMessage(1), 1);
      //throw ApiException("Ha ocurrido un error, inténtalo más tarde", -1);
    }
  }

  /// Request per mètode POST
  Future<dynamic> apiPOSTRequest(Uri uri, String params) async {
    try {
      print("URL: " + uri.toString());
      print("Params: " + params);

      HttpClient http = HttpClient();

      HttpClientRequest request = await http.postUrl(uri);

      // Indiquem headers
      request.headers.set("content-type", "application/json");

      // Afegim paràmetres
      request.add(utf8.encode(params));

      var response = await request.close();
      //var response = await (await http.postUrl(uri)).close();

      print("RESPONSE: " + response.statusCode.toString());
      print("RESPONSE reason phrase: " + response.reasonPhrase);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = await response.transform(utf8.decoder).join();
        print(decodedResponse);
        return json.decode(decodedResponse);
      } else if (response.statusCode >= 400 && response.statusCode <= 599) {
        throw ApiException("Client error", response.statusCode);
      }
    } catch (e) {
      print("ERRRR:$e");
      throw ApiException(getRCMessage(1), 1);
      //throw ApiException("Ha ocurrido un error, inténtalo más tarde", -1);
    }
  }

  /// Request per mètode POST amb Authentication
  /// es fa servir el access token de l'usuari
  Future<dynamic> apiPOSTAuthRequest(
      Uri uri, String params, String accessToken) async {
    try {
      print("URL: $uri");
      print("Params: $params");

      HttpClient http = HttpClient();

      HttpClientRequest request = await http.postUrl(uri);

      // Indiquem headers
      request.headers
          .set(HttpHeaders.authorizationHeader, 'Bearer $accessToken');
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json");

      // Afegim paràmetres
      if (params != null) request.add(utf8.encode(params));

      var response = await request.close();
      //var response = await (await http.postUrl(uri)).close();

      print("RESPONSE: " + response.statusCode.toString());
      print("RESPONSE reason phrase: " + response.reasonPhrase);
      print("RESPONSE reason headers: ");
      print(response.headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = await response.transform(utf8.decoder).join();
        print(decodedResponse);
        return json.decode(decodedResponse);
      } else if (response.statusCode >= 400 && response.statusCode <= 599) {
        throw ApiException("Client error", response.statusCode);
      }
    } catch (e) {
      throw ApiException(getRCMessage(1), 1);
    }
  }

  String getRCMessage(int rc) {
    // Agafem string traduccions
    String returnMesgage = returnCodes[rc];

    if (returnMesgage != null) {
      return returnMesgage;
    } else {
      return returnCodes[1];
    }
  }*/
}
