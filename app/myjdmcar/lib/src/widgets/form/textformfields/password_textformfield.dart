import 'package:flutter/material.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextFormField({Key key, @required this.controller}) : super(key: key); 
  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _passwordVisible = false;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validatePassword,
        obscureText: !_passwordVisible,
        controller:  widget.controller,
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context)
                .translate("passwordTextFormFieldLabel"),
            hintText: AppLocalizations.of(context)
                .translate("passwordTextFormFieldHint"),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )),
        onChanged: (value) {
          setState(() {
            variable2 = value;
          });
        });
  }

  ///Función que comprueba que el campo de texto de la contraseña
  ///sea mayor o igual a 8 dígitos
  String validatePassword(String password) {
    if (!isPasswordValid(password)) {
      return AppLocalizations.of(context)
          .translate("passwordTextFormFieldError");
    }
    return null;
  }
}
