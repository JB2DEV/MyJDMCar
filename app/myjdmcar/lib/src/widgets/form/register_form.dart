import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/email_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/password_textformfield.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/username_textformfield.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  RegisterForm({Key key, this.formKey, @required this.usernameController, @required this.emailController, @required this.passwordController}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          UsernameTextFormField(controller: widget.usernameController),
          SizedBox(height: 35),
          EmailTextFormField(controller: widget.emailController,),
          SizedBox(height: 35),
          PasswordTextFormField(controller: widget.passwordController,),  
        ],
      ),
    );
  }
}
