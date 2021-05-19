import 'package:flutter/material.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class PasswordTextFormField extends StatefulWidget {
  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validatePassword,
        obscureText: !_passwordVisible,
        controller: passwordController,
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

  String validatePassword(String password) {
    if (!isPasswordValid(password)) {
      return AppLocalizations.of(context)
          .translate("passwordTextFormFieldError");
    }
    return null;
  }
}
