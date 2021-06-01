import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class CarPartTextFormField extends StatefulWidget {
  final TextEditingController controller;
  CarPartTextFormField({Key key, @required this.controller}) : super(key: key);

  @override
  _CarPartTextFormFieldState createState() => _CarPartTextFormFieldState();
}

class _CarPartTextFormFieldState extends State<CarPartTextFormField> {

  @override
  void dispose() { 
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateTextFormField,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)
            .translate("carPartTextFormFieldLabel"),
        hintText: AppLocalizations.of(context)
            .translate("carPartTextFormFieldHint"),
      ),
    );
  }

  String validateTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carPartTextFormFieldError");
    return null;
  }
}
