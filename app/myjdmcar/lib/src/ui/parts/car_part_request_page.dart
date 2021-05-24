import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/src/widgets/buttons/theme_button.dart';
import 'package:myjdmcar/src/widgets/form/car_part_request_form.dart';

class CarPartRequestPage extends StatefulWidget {
  const CarPartRequestPage({Key key}) : super(key: key);

  @override
  _CarPartRequestPageState createState() => _CarPartRequestPageState();
}

class _CarPartRequestPageState extends State<CarPartRequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("carPartRequestPageTitle"),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CarPartRequestForm(
                formKey: _formKey,
              ),
              SizedBox(
                height: 30,
              ),
              ThemeButton(
                buttonText: AppLocalizations.of(context)
                    .translate("carPartRequestPageButtonText"),
                function: _sendCarPartRequest,
              )
            ],
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
