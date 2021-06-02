import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/utils/utils.dart';

class NewPasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;
  NewPasswordTextFormField({Key key, @required this.controller})
      : super(key: key);

  @override
  _NewPasswordTextFormFieldState createState() =>
      _NewPasswordTextFormFieldState();
}

class _NewPasswordTextFormFieldState extends State<NewPasswordTextFormField> {
  bool _passwordVisible = false;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatePassword,
      obscureText: !_passwordVisible,
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)
              .translate("newPasswordTextFormFieldLabel"),
          hintText: AppLocalizations.of(context)
              .translate("newPasswordTextFormFieldHint"),
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
    );
  }

  ///Función que comprueba que el campo de texto de la nueva
  ///contraseña sea mayor o igual a 8 dígitos
  String validatePassword(String password) {
    if (!isPasswordValid(password)) {
      return AppLocalizations.of(context)
          .translate("newPasswordTextFormFieldError");
    }
    return null;
  }
}
