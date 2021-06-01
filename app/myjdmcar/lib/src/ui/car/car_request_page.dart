import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/form/car_request_form.dart';

class CarRequestPage extends StatefulWidget {
  CarRequestPage({Key key}) : super(key: key);

  @override
  _CarRequestPageState createState() => _CarRequestPageState();
}

class _CarRequestPageState extends State<CarRequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).translate("carRequestPageTitle"),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CarRequestForm(
                  formKey: _formKey,
                ),
                SizedBox(
                  height: 30,
                ),
                ThemeButton(
                  buttonText: AppLocalizations.of(context)
                      .translate("carRequestPageButtonText"),
                  function: _sendCarPartRequest,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendCarPartRequest() {
    if (_formKey.currentState.validate()) {
      print("validated");
    } else {
      print("Not validated");
    }
  }
}
