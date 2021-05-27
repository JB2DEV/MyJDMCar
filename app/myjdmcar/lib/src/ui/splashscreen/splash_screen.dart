import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/models/user.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:myjdmcar/src/ui/auth/sign_in_page.dart';
import 'package:myjdmcar/src/ui/home/home_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 2;
  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    UserModel loggedUser = await _apiClient.getLoggedUser();
    if (loggedUser.accessToken.length <= 0) {
      return Timer(_duration, navigationSignInPage);
    } else {
      await _apiClient.getFirstCarData().then((car) {
        Provider.of<UserCarProvider>(context, listen: false).carId = car.id;
        Provider.of<UserCarProvider>(context, listen: false).carModel =
            car.carBrand.name + ' ' + car.carModel.name;
      });
      return Timer(_duration, navigationHomePage);
    }
  }

  void navigationSignInPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => SignInPage()));
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
                        'assets/images/logo_provisional.png',
                        height: 300,
                        width: 300,
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
