import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/decoration/logo_app.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/email_textformfield.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
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
              Text(AppLocalizations.of(context)
                    .translate("recoverPasswordPageTitle")),
              SizedBox(height: 30),
              Text(AppLocalizations.of(context)
                    .translate("recoverPasswordPageSubtitle")),
              SizedBox(height: 30),
              Form(key: _formKey, child: EmailTextFormField()),
              SizedBox(height: 30),
              SizedBox(
                height: 80,
              ),
              ThemeButton(function: validateForm, buttonText: AppLocalizations.of(context)
                    .translate("recoverPasswordPageButtonText")
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
      Navigator.pop(context);
    } else {
      print("Not validated");
    }
  }
}
