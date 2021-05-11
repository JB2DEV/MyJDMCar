import 'package:flutter/material.dart';
import 'package:myjdmcar/config/app_colors.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/decoration/logo_app.dart';
import 'package:myjdmcar/src/widgets/form/login_form.dart';
import 'package:myjdmcar/utils/utils.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      AppLocalizations.of(context)
                          .translate("loginPageForgotPassword"),
                      style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "recover_password_page"),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("loginPageRecoverPassword"),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.green_jdm_arrow)
                      )),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              ThemeButton(
                function: validateForm,
                buttonText: AppLocalizations.of(context)
                    .translate("loginPageButtonText")
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
                    style: Theme.of(context).textTheme.bodyText2,
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
                        style: Theme.of(context).textTheme.bodyText1.copyWith(color: AppColors.green_jdm_arrow)
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
