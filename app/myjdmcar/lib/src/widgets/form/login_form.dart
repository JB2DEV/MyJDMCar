import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/email_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/password_textformfield.dart';

class LoginForm extends StatelessWidget {

  final GlobalKey<FormState> formKey;

  const LoginForm({Key key, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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