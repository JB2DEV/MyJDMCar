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
              ElevatedButton(onPressed: addCar, child: Text("INSERT")),
              ElevatedButton(onPressed: deleteCar, child: Text("DELETE")),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void addCar() async {
    ApiClient _apiClient = ApiClient();
    bool insert = await _apiClient.addCar(context, 1, 1);

    if (insert) {
      Navigator.of(context).popAndPushNamed("home_page");
    }
  }

  void deleteCar() async {
    ApiClient _apiClient = ApiClient();
    int carId =
        await Provider.of<UserCarProvider>(context, listen: false).carId;
    bool insert = await _apiClient.deleteCar(carId);

    if (insert) {
      await _apiClient.getFirstCarData().then((car) {
        Provider.of<UserCarProvider>(context, listen: false).carId = car.id;
        Provider.of<UserCarProvider>(context, listen: false).carModel =
            car.carBrand.name + ' ' + car.carModel.name;
      });

      Navigator.of(context).popAndPushNamed("home_page");
    }
  }
}
