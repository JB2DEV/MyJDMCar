import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class CarPartBrandTextFormField extends StatefulWidget {
  CarPartBrandTextFormField({Key key}) : super(key: key);

  @override
  _CarPartBrandTextFormFieldState createState() =>
      _CarPartBrandTextFormFieldState();
}

class _CarPartBrandTextFormFieldState extends State<CarPartBrandTextFormField> {
  final TextEditingController _carPartBrandController = TextEditingController();
  var items = [
    'None',
    'Working a lot harder',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a lot smarter',
    'Being a self-starter',
    'Placed in charge of trading charter'
  ];

  @override
  void dispose() {
    _carPartBrandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateTextFormField,
      keyboardType: TextInputType.text,
      controller: _carPartBrandController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)
            .translate("carPartBrandTextFormFieldLabel"),
        hintText: AppLocalizations.of(context)
            .translate("carPartBrandTextFormFieldHint"),
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: (String value) {
            if (value == 'None') {
              _carPartBrandController.text = "";
            } else {
              _carPartBrandController.text = value;
            }
          },
          itemBuilder: (BuildContext context) {
            return items.map<PopupMenuItem<String>>((String value) {
              return new PopupMenuItem(child: new Text(value), value: value);
            }).toList();
          },
        ),
      ),
    );
  }

  String validateTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carPartBrandTextFormFieldError");
    return null;
  }
}
