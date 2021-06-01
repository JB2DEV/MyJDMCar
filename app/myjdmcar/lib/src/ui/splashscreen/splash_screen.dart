import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/car.dart';
import 'package:myjdmcar/models/user.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:myjdmcar/src/ui/auth/sign_in_page.dart';
import 'package:myjdmcar/src/ui/car/add_car_page.dart';
import 'package:myjdmcar/src/ui/home/home_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final splashDelay = 2;
  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadWidget();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    UserModel loggedUser = await _apiClient.getLoggedUser();
    if (loggedUser.accessToken.length <= 0) {
      return Timer(_duration, navigationSignInPage);
    } else {
      CarModel car = await _apiClient.getFirstCarData();
      if (car != null) {
        Provider.of<UserCarProvider>(context, listen: false).carId = car.id;
        Provider.of<UserCarProvider>(context, listen: false).carModel =
            car.carBrand.name + ' ' + car.carModel.name;
        return Timer(_duration, navigationHomePage);
      } else {
        return Timer(_duration, navigationAddCarPage);
      }
    }
  }

  void navigationSignInPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
  }

  void navigationAddCarPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => AddCarPage()));
  }

  void navigationHomePage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        height: 500,
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.green_jdm_arrow),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
