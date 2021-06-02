import 'package:flutter/material.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class UsernameTextFormField extends StatefulWidget {
  final TextEditingController controller;
  UsernameTextFormField({Key key, @required this.controller}) : super(key: key);

  @override
  _UsernameTextFormFieldState createState() => _UsernameTextFormFieldState();
}

class _UsernameTextFormFieldState extends State<UsernameTextFormField> {

  @override
  void dispose() { 
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validateTextField,
        keyboardType: TextInputType.name,
        controller: widget.controller,
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
  ///Función que comprueba que el campo de texto del
  ///nombre de usuario no esté vacío
  String validateTextField(String value) {
    if (isTextFieldEmpty(value)) {
      return AppLocalizations.of(context)
          .translate("usernameTextFormFieldError");
    }
    return null;
  }
}
