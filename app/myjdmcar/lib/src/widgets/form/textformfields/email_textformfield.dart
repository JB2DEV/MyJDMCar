import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class EmailTextFormField extends StatefulWidget {
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateEmail,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: InputDecoration(
          labelText:
              AppLocalizations.of(context).translate("emailTextFormFieldLabel"),
          hintText:
              AppLocalizations.of(context).translate("emailTextFormFieldHint")),
    );
  }

  String validateEmail(String email) {
    // isEmailValid ==> Utils Method
    if (!isEmailValid(email)) {
      return AppLocalizations.of(context)
          .translate("emailTextFormFieldValidationError");
    }
    return null;
  }
}
