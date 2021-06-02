import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
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
  final TextEditingController carBrandController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  ApiClient _apiClient = ApiClient();
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
                  carBrandController: carBrandController,
                  carModelsController: carModelController,
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

  void _sendCarPartRequest() async {
    if (_formKey.currentState.validate()) {
      print("validated");
      await _apiClient.requestMissing(
          carBrandController.text, carModelController.text, null);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text(AppLocalizations.of(context)
                      .translate("carRequestPageScaffoldMessageSend")),
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } else {
      print("Not validated");
    }
  }
}
