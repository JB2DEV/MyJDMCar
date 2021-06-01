import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';

class OtherInfoTextFormField extends StatefulWidget {
  final TextEditingController controller;
  OtherInfoTextFormField({Key key, @required this.controller}) : super(key: key);

  @override
  _OtherInfoTextFormFieldState createState() => _OtherInfoTextFormFieldState();
}

class _OtherInfoTextFormFieldState extends State<OtherInfoTextFormField> {

  @override
  void dispose() { 
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 10,
      maxLength: 400,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText:
            AppLocalizations.of(context).translate("otherInfoTextFormFieldLabel"),
        hintText:
            AppLocalizations.of(context).translate("otherInfoTextFormFieldHint"),
      ),
    );
  }
}
