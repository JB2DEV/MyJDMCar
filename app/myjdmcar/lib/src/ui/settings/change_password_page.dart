import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
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

  ApiClient _apiClient = ApiClient();

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Nuevas contraseñas diferentes entre ellas'),
        ));
      } else {
        bool changed = await _apiClient.changePassword(
            actualPasswordController.text, newPasswordController1.text);
        if (changed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Contraseña cambiada correctamente'),
          ));
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            content: Text('La contraseña actual no es correcta'),
          ));
        }
      }
    } else {
      print("Not validated");
    }
  }
}
