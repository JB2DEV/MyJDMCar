import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/decoration/logo_app.dart';
import 'package:myjdmcar/src/widgets/form/register_form.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              LogoApp(),
              SizedBox(height: 50),
              Text(
                AppLocalizations.of(context).translate("signUpPageTitle"),
                style: Theme.of(context).textTheme.headline1,
              ),
              RegisterForm(
                formKey: _formKey,
                emailController: emailController,
                passwordController: passwordController,
                usernameController: usernameController,
              ),
              SizedBox(
                height: 80,
              ),
              ThemeButton(
                  function: validateForm,
                  buttonText: AppLocalizations.of(context)
                      .translate("signUpPageButtonText")
                      .toUpperCase()),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  ///Valida el que el formulario cumpla las restricciones
  void validateForm() async {
    if (_formKey.currentState.validate()) {
      print("validated");
      try {
        await _apiClient.mySignUp(usernameController.text,emailController.text,passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Cuenta creada correctamente'),
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } on Exception catch (_) {
        print("Error signup");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          content: Text(AppLocalizations.of(context).translate("signUpPageScaffoldMessageSignUpError")),
        ));
      }
    } else {
      print("Not validated");
    }
  }
}
