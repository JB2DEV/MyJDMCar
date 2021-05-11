import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/decoration/logo_app.dart';
import 'package:myjdmcar/src/widgets/form/login_form.dart';

import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              SizedBox(height: 30),
              Text(AppLocalizations.of(context).translate("loginPageTitle"),
                  style: Theme.of(context).textTheme.headline1),
              LoginForm(
                formKey: _formKey,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate("loginPageForgotPassword"),
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "recover_password_page"),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("loginPageRecoverPassword"),
                        style: TextStyle(
                            color: AppColors.green_jdm_arrow,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              ThemeButton(
                function: validateForm,
                buttonText: AppLocalizations.of(context)
                    .translate("loginButtonText")
                    .toUpperCase(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate("loginPageHaveAccount"),
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "sign_up_page");
                      },
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("loginPageRegister"),
                        style: TextStyle(
                            color: AppColors.green_jdm_arrow,
                            fontWeight: FontWeight.bold),
                      )),
                ],
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
      Navigator.popAndPushNamed(context, "home_page");
    } else {
      print("Not validated");
    }
  }
}
