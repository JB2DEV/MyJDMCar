import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
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
  final TextEditingController carPartBrandController = TextEditingController();
  final TextEditingController carPartController = TextEditingController();
  final TextEditingController otherInfoController = TextEditingController();
  ApiClient _apiClient = ApiClient();

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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CarPartRequestForm(
                  formKey: _formKey,
                  carPartBrandController: carPartBrandController,
                  carPartController: carPartController,
                  otherInfoController: otherInfoController,
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
      ),
    );
  }

  void _sendCarPartRequest() async {
    if (_formKey.currentState.validate()) {
      print("validated");
      await _apiClient.requestMissing(carPartBrandController.text,
          carPartController.text, otherInfoController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text(AppLocalizations.of(context).translate("carPartRequestPageScaffoldMessageSend")),
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      print("Not validated");
    }
  }
}
