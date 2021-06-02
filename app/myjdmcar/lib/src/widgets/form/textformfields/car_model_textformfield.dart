import 'package:flutter/material.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/utils/utils.dart';

class CarModelTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final Future carModelsData;
  CarModelTextFormField(
      {Key key,
      @required this.controller,
      @required this.carModelsData})
      : super(key: key);

  @override
  _CarModelTextFormFieldState createState() => _CarModelTextFormFieldState();
}

class _CarModelTextFormFieldState extends State<CarModelTextFormField> {
  List<CarModelModel> carModelsList;
  List<String> items = [];

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
            .translate("carModelTextFormFieldLabel"),
        hintText:
            AppLocalizations.of(context).translate("carModelTextFormFieldHint"),
        suffixIcon: FutureBuilder(
          future: widget.carModelsData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print(snapshot.hasData);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('');
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
                  items.add(AppLocalizations.of(context).translate("carModelTextFormFieldNoneValue"));
                   List<CarModelModel> carModelList = snapshot.data;
                  carModelList.forEach((element) {
                    items.add(element.name + " (" + element.engine + ")");
                  });
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      if (value == AppLocalizations.of(context).translate("carModelTextFormFieldNoneValue")) {
                        widget.controller.text = "";
                      } else {
                        widget.controller.text = value;
                       
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

  ///Función que comprueba que el campo de texto del modelo
  ///del coche no esté vacío
  String validateTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carModelTextFormFieldError");
    return null;
  }
}
