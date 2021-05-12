import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/email_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/password_textformfield.dart';

class LoginForm extends StatefulWidget {

  final GlobalKey<FormState> formKey;

  const LoginForm({Key key, @required this.formKey}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          EmailTextFormField(),
          SizedBox(
              height: 35
          ),
          PasswordTextFormField(),
        ],
      ),
    );
  }
}