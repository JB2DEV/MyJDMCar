import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/email_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/password_textformfield.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController emailController;

  const LoginForm({Key key, @required this.formKey, @required this.passwordController, @required this.emailController}) : super(key: key);

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
          EmailTextFormField(
            controller: widget.emailController,
          ),
          SizedBox(height: 35),
          PasswordTextFormField(
            controller: widget.passwordController,
          ),
        ],
      ),
    );
  }
}
