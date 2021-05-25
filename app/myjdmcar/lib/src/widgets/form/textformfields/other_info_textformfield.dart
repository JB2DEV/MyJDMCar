import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';

class OtherInfoTextFormField extends StatefulWidget {
  OtherInfoTextFormField({Key key}) : super(key: key);

  @override
  _OtherInfoTextFormFieldState createState() => _OtherInfoTextFormFieldState();
}

class _OtherInfoTextFormFieldState extends State<OtherInfoTextFormField> {
  final TextEditingController _otherInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 10,
      maxLength: 400,
      keyboardType: TextInputType.text,
      controller: _otherInfoController,
      decoration: InputDecoration(
        labelText:
            AppLocalizations.of(context).translate("otherInfoTextFormFieldLabel"),
        hintText:
            AppLocalizations.of(context).translate("otherInfoTextFormFieldHint"),
      ),
    );
  }
}
