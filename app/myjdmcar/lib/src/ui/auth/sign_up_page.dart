import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/decoration/logo_app.dart';
import 'package:myjdmcar/src/widgets/form/register_form.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              LogoApp(),
              SizedBox(height: 50),
              Text(
                AppLocalizations.of(context).translate("signUpPageTitle"),
                style: Theme.of(context).textTheme.headline1,
              ),
              RegisterForm(formKey: _formKey),
              SizedBox(
                height: 80,
              ),
              ThemeButton(
                  function: validateForm,
                  buttonText: AppLocalizations.of(context)
                      .translate("signUpPageButtonText")
                      .toUpperCase()),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  ///Valida el que el formulario cumpla las restricciones
  void validateForm() {
    if (_formKey.currentState.validate()) {
      print("validated");
      try {
        insertOne();
        Navigator.pop(context);
      } on Exception catch (_) {
        print("Error");
      }
    } else {
      print("Not validated");
    }
  }

  void insertOne() async {
    var url = '10.0.2.2:80';
    var test = '/auth/signup.php';
    Map<String, dynamic> toJson() =>
        {'user': variable3, 'email': variable1, 'pass': variable2};
    final response = await http.post(Uri.http(url, test), body: toJson());
    final decodedJson = await json.decode(response.body);
    print(decodedJson);
  }
}
