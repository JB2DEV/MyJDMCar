import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/email_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/password_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppButtons extends StatefulWidget {
  const AppButtons({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppButtons();
}

class _AppButtons extends State<AppButtons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(onPressed: addCar, child: Text("send mail")),
              //ElevatedButton(onPressed: deleteCar, child: Text("user")),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void addCar() async {
    /* ApiClient _apiClient = ApiClient();
    bool insert = await _apiClient.changePassword("adminadmin", "password");

    if (insert) {
      Navigator.of(context).popAndPushNamed("home_page");
    }
    
     final Email email = Email(
      body: 'La contraseña temporal es: ',
      subject: '[MyJDMCar] - Solicitud de cambio de contraseña',
      recipients: ['mrbema222@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

    */
  }

  void deleteCar() async {
    ApiClient _apiClient = ApiClient();
    String username = "admin";
    bool insert = await _apiClient.changeUsername(username);

    if (insert) {
      Navigator.of(context).popAndPushNamed("home_page");
    }
  }
}
