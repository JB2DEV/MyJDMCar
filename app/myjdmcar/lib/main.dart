import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myjdmcar/config/app_styles.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/config/navigator_routes.dart';
import 'package:myjdmcar/src/ui/auth/sign_in_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyJDMCar',
      theme: AppStyles.mainTheme,
      routes: getAppRoutes(),
      home: SignInPage(),
      supportedLocales: [Locale("en"), Locale("es"), Locale("ca")],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FallbackCupertinoLocalisationsDelegate(),
      ],
    );
  }
}
