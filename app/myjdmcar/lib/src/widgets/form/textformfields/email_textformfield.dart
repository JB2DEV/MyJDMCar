import 'package:flutter/material.dart';
import 'package:myjdmcar/config/globals.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class EmailTextFormField extends StatefulWidget {
  final TextEditingController controller;

  const EmailTextFormField({Key key, @required this.controller}) : super(key: key);
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {

  @override
  void dispose() { 
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validateEmail,
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: AppLocalizations.of(context)
                .translate("emailTextFormFieldLabel"),
            hintText: AppLocalizations.of(context)
                .translate("emailTextFormFieldHint")),
        onChanged: (value) {
          setState(() {
            variable1 = value;
          });
        });
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
