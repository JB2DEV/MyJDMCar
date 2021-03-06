import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_brand.dart';
import 'package:myjdmcar/utils/utils.dart';

class CarRequestForm extends StatefulWidget {
  final TextEditingController carBrandController;
  final TextEditingController carModelsController;

  final GlobalKey<FormState> formKey;

  CarRequestForm(
      {Key key,
      @required this.formKey,
      @required this.carBrandController,
      @required this.carModelsController})
      : super(key: key);

  @override
  _CarRequestFormState createState() => _CarRequestFormState();
}

class _CarRequestFormState extends State<CarRequestForm> {
  ApiClient _apiClient = ApiClient();

  Future carBrandsData;
  Future carModelsData;

  List<String> carBrandsItems = [];
  List<String> carModelsItems = [];

  @override
  void dispose() {
    widget.carBrandController.dispose();
    widget.carModelsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    carBrandsData = _apiClient.getCarBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
          ),
          _getCarBrandTextFormField(),
          SizedBox(
            height: 60,
          ),
          _getCarModelsTextFormField(),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }

  ///Método para obtener el campo de texto de la marca del coche
  Widget _getCarBrandTextFormField() {
    return TextFormField(
      validator: validateCarBrandTextFormField,
      keyboardType: TextInputType.text,
      controller: widget.carBrandController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)
            .translate("carBrandTextFormFieldLabel"),
        hintText:
            AppLocalizations.of(context).translate("carBrandTextFormFieldHint"),
        suffixIcon: FutureBuilder<List<CarBrandModel>>(
          future: carBrandsData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                  List<CarBrandModel> carBrands = snapshot.data;
                  carBrands.forEach((element) {
                    carBrandsItems.add(element.name);
                  });
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      if (value ==
                          AppLocalizations.of(context)
                              .translate("addCarPageNoneSelectedPopUpMenu")) {
                        widget.carBrandController.text = "";
                      } else {
                        setState(() {
                          widget.carBrandController.text = value;
                        });
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return carBrandsItems
                          .map<PopupMenuItem<String>>((String value) {
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

  ///Función que valida si el campo de texto de la marca del coche
  ///está vacío
  String validateCarBrandTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carBrandTextFormFieldError");
    return null;
  }

  ///Método para obtener el campo de texto del modelo del coche
  Widget _getCarModelsTextFormField() {
    return TextFormField(
      validator: validateCarModelTextFormField,
      keyboardType: TextInputType.text,
      controller: widget.carModelsController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)
            .translate("carModelTextFormFieldLabel"),
        hintText:
            AppLocalizations.of(context).translate("carModelTextFormFieldHint"),
      ),
    );
  }

  ///Función que valida si el campo de texto del modelo del coche
  ///está vacío
  String validateCarModelTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carModelTextFormFieldError");
    return null;
  }

}
