

import 'package:myjdmcar/models/user.dart';


import 'api_client.dart';

class RequestProvider {
  RequestProvider();

  ApiClient _apiClient = ApiClient();

  Future<User> signUp(String email, String password) async {
    return _apiClient.signUp(email, password);
  }

  Future<User> signIn(String email, String password) async {
    return _apiClient.signIn(email, password);
  }

  Future<dynamic> forget(String email) async {
    return _apiClient.forget(email);
  }

  Future<dynamic> editUser(String email, String accessToken) async {
    return _apiClient.editUser(email, accessToken);
  }

  Future<dynamic> changePassword(String password, String accessToken) async {
    return _apiClient.changePassword(password, accessToken);
  }
}
