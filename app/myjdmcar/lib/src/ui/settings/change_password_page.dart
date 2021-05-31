import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/new_password_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/password_textformfield.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController actualPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController1 = TextEditingController();
  final TextEditingController newPasswordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  PasswordTextFormField(
                    controller: actualPasswordController,
                  ),
                  SizedBox(height: 50),
                  NewPasswordTextFormField(
                    controller: newPasswordController1,
                  ),
                  SizedBox(height: 50),
                  NewPasswordTextFormField(
                    controller: newPasswordController2,
                  ),
                  SizedBox(height: 50),
                  ThemeButton(
                      function: changePassword,
                      buttonText: AppLocalizations.of(context)
                          .translate("changePasswordButtonText"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changePassword() async {
    if (_formKey.currentState.validate()) {
      print("validated");
      if (newPasswordController1.text != newPasswordController2.text) {
        print("Nuevas contraseñas diferentes entre ellas");
      }
    } else {
      print("Not validated");
    }
  }
}
