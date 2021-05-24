import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class CarPartTextFormField extends StatefulWidget {
  CarPartTextFormField({Key key}) : super(key: key);

  @override
  _CarPartTextFormFieldState createState() => _CarPartTextFormFieldState();
}

class _CarPartTextFormFieldState extends State<CarPartTextFormField> {
  final TextEditingController _carPartController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateTextFormField,
      keyboardType: TextInputType.text,
      controller: _carPartController,
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
