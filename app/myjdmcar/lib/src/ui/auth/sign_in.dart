import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text( AppLocalizations.of(context)
                .translate("hello")),
          ),
        ],
      )
    );
  }
}
