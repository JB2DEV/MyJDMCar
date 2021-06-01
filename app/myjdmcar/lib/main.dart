import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myjdmcar/config/app_styles.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/config/navigator_routes.dart';
import 'package:myjdmcar/provider/add_car_provider.dart';
import 'package:myjdmcar/provider/car_parts_type_provider.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:myjdmcar/src/ui/splashscreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => CarPartsFilterProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => UserCarProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => AddCarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyJDMCar',
        theme: AppStyles.mainTheme,
        routes: getAppRoutes(),
        home: SplashScreen(),
        supportedLocales: [Locale("en"), Locale("es"), Locale("ca")],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FallbackCupertinoLocalisationsDelegate(),
        ],
      ),
    );
    //
  }
}
