import 'package:flutter/material.dart';
import 'package:myjdmcar/src/ui/auth/recover_password_page.dart';
import 'package:myjdmcar/src/ui/auth/sign_in_page.dart';
import 'package:myjdmcar/src/ui/auth/sign_up_page.dart';
import 'package:myjdmcar/src/ui/car/add_car_page.dart';
import 'package:myjdmcar/src/ui/car/user_car_detail_page.dart';
import 'package:myjdmcar/src/ui/home/home_page.dart';
import 'package:myjdmcar/src/ui/parts/add_car_part_page.dart';
import 'package:myjdmcar/src/ui/parts/car_part_request_page.dart';
import 'package:myjdmcar/src/ui/test/buttons.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    "sign_in_page":               (BuildContext context) => SignInPage(),
    "sign_up_page":               (BuildContext context) => SignUpPage(),
    "recover_password_page":      (BuildContext context) => RecoverPasswordPage(),
    "home_page":                  (BuildContext context) => HomePage(),
    "user_car_detail_page":       (BuildContext context) => UserCarDetailPage(),
    "add_car_part_page":          (BuildContext context) => AddCarPartPage(),
    "car_part_request_page":      (BuildContext context) => CarPartRequestPage(),
    "add_car_page" :              (BuildContext context) => AddCarPage(),
  };
}
