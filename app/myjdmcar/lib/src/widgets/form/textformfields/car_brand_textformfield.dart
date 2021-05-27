import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_brand.dart';
import 'package:myjdmcar/provider/add_car_provider.dart';
import 'package:myjdmcar/utils/utils.dart';
import 'package:provider/provider.dart';

class CarBrandTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final Future carBrandsData;
  final Function function;
  CarBrandTextFormField(
      {Key key,
      @required this.controller,
      @required this.carBrandsData,
      this.function})
      : super(key: key);

  @override
  _CarBrandTextFormFieldState createState() => _CarBrandTextFormFieldState();
}

class _CarBrandTextFormFieldState extends State<CarBrandTextFormField> {
  List<CarBrandModel> carBrandsList;
  ApiClient _apiClient = ApiClient();
  var items = ['None'];

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: validateTextFormField,
      keyboardType: TextInputType.text,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)
            .translate("carBrandTextFormFieldLabel"),
        hintText:
            AppLocalizations.of(context).translate("carBrandTextFormFieldHint"),
        suffixIcon: FutureBuilder<List<CarBrandModel>>(
          future: widget.carBrandsData,
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
                  items.clear();
                  items.add('None');
                  List<CarBrandModel> carBrands = snapshot.data;
                  carBrands.forEach((element) {
                    items.add(element.name);
                  });
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      if (value == 'None') {
                        widget.controller.text = "";
                      } else {
                        widget.controller.text = value;
                        Provider.of<AddCarProvider>(context, listen: false).currentBrand =
                            value;
                            if(widget.function != null) widget.function();
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
          .translate("carBrandTextFormFieldError");
    return null;
  }
}
