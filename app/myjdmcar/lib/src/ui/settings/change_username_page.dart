import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/decoration/logo_app.dart';
import 'package:myjdmcar/src/widgets/form/textformfields/username_textformfield.dart';

class ChangeUsernamePage extends StatefulWidget {
  ChangeUsernamePage({Key key}) : super(key: key);

  @override
  _ChangeUsernamePageState createState() => _ChangeUsernamePageState();
}

class _ChangeUsernamePageState extends State<ChangeUsernamePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

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
                AppLocalizations.of(context)
                    .translate("changeUsernamePageText"),
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child: UsernameTextFormField(
                    controller: usernameController,
                  )),
              SizedBox(
                height: 60,
              ),
              ThemeButton(
                  function: changeUsername,
                  buttonText: AppLocalizations.of(context)
                      .translate("changeUsernamePageButtonText")),
            ],
          ),
        ),
      ),
    ));
  }

  void changeUsername() async {
    if (_formKey.currentState.validate()) {
      print("validated");
      bool changed = await _apiClient.changeUsername(usernameController.text);
      if (changed) {
        Navigator.popUntil(context, ModalRoute.withName("settings_page"));
        //Navigator.pushNamedAndRemoveUntil(context, "settings_page", (route) => false);
      }
    } else {
      print("Not validated");
    }
  }
}
