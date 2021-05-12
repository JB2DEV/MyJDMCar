import 'package:flutter/material.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class UsernameTextFormField extends StatefulWidget {
  UsernameTextFormField({Key key}) : super(key: key);

  @override
  _UsernameTextFormFieldState createState() => _UsernameTextFormFieldState();
}

class _UsernameTextFormFieldState extends State<UsernameTextFormField> {
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validateTextField,
        keyboardType: TextInputType.name,
        controller: usernameController,
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context)
                .translate("usernameTextFormFieldLabel"),
            hintText: AppLocalizations.of(context)
                .translate("usernameTextFormFieldHint")),
        onChanged: (value) {
          setState(() {
            variable3 = value;
          });
        });
  }

  ///Valida que el textfield no esté vacío
  String validateTextField(String value) {
    if (isTextFieldEmpty(value)) {
      return AppLocalizations.of(context)
          .translate("usernameTextFormFieldError");
    }
    return null;
  }
}
