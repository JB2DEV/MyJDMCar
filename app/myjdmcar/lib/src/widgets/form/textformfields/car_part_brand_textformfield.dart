import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client_test.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_part_brand.dart';
import 'package:myjdmcar/utils/utils.dart';

class CarPartBrandTextFormField extends StatefulWidget {
  CarPartBrandTextFormField({Key key}) : super(key: key);

  @override
  _CarPartBrandTextFormFieldState createState() =>
      _CarPartBrandTextFormFieldState();
}

class _CarPartBrandTextFormFieldState extends State<CarPartBrandTextFormField> {
  final TextEditingController _carPartBrandController = TextEditingController();
  Future carPartsBrands;
  ApiClientTest apiClientTest = ApiClientTest();

  var items = [
    'None',
  ];

  @override
  void dispose() {
    _carPartBrandController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    carPartsBrands = apiClientTest.getCarPartsBrands();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateTextFormField,
      keyboardType: TextInputType.text,
      controller: _carPartBrandController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)
            .translate("carPartBrandTextFormFieldLabel"),
        hintText: AppLocalizations.of(context)
            .translate("carPartBrandTextFormFieldHint"),
        suffixIcon: FutureBuilder<List<CarPartBrandModel>>(
          future: carPartsBrands,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print("SNAPSHOT ERROR");
            print(snapshot.error);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Input a URL to start');
              case ConnectionState.waiting:
                print("waiting");
                return CircularProgressIndicator();
              case ConnectionState.active:
                print("active");
                return Text('active');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  print("has Error");
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  List<CarPartBrandModel> carPartBrands = snapshot.data;
                  carPartBrands.forEach((element) {
                    items.add(element.name);
                  });
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      if (value == 'None') {
                        _carPartBrandController.text = "";
                      } else {
                        _carPartBrandController.text = value;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return items.map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  );
                }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  String validateTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carPartBrandTextFormFieldError");
    return null;
  }
}
