import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client_test.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_brand.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/provider/add_car_provider.dart';
import 'package:myjdmcar/utils/utils.dart';
import 'package:provider/provider.dart';

class AddCarForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  AddCarForm({Key key, @required this.formKey}) : super(key: key);

  @override
  _AddCarFormState createState() => _AddCarFormState();
}

class _AddCarFormState extends State<AddCarForm> {
  final TextEditingController _carBrandController = TextEditingController();
  final TextEditingController _carModelsController = TextEditingController();
  final ApiClientTest apiClientTest = ApiClientTest();

  Future carBrandsData;
  Future carModelsData;

  var carBrandsItems = ['None'];
  var carModelsItems = ['None'];

  @override
  void dispose() {
    _carBrandController.dispose();
    _carModelsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    carBrandsData = apiClientTest.getCarBrands();
  }

  @override
  Widget build(BuildContext context) {
    print("PROVIDER: " +
        Provider.of<AddCarProvider>(context, listen: false).currentBrand);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _getCarBrandTextFormField(),
          SizedBox(
            height: 30,
          ),
          Text(
              Provider.of<AddCarProvider>(context, listen: false).currentBrand),
          SizedBox(
            height: 30,
          ),
          _getCarModelsTextFormField(),
        ],
      ),
    );
  }

  Widget _getCarBrandTextFormField() {
    return TextFormField(
      readOnly: true,
      validator: validateCarBrandTextFormField,
      keyboardType: TextInputType.text,
      controller: _carBrandController,
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
                  carBrandsItems.clear();
                  carBrandsItems.add('None');
                  List<CarBrandModel> carBrands = snapshot.data;
                  carBrands.forEach((element) {
                    carBrandsItems.add(element.name);
                  });
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      if (value == 'None') {
                        _carBrandController.text = "";
                      } else {
                        setState(() {
                          _carBrandController.text = value;
                          Provider.of<AddCarProvider>(context, listen: false)
                              .currentBrand = value;
                        });
                        _loadCarModelsData();
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

  String validateCarBrandTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carBrandTextFormFieldError");
    return null;
  }

  Widget _getCarModelsTextFormField() {
    return TextFormField(
      readOnly: true,
      validator: validateCarModelTextFormField,
      keyboardType: TextInputType.text,
      controller: _carModelsController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)
            .translate("carModelTextFormFieldLabel"),
        hintText:
            AppLocalizations.of(context).translate("carModelTextFormFieldHint"),
        suffixIcon: FutureBuilder<List<CarModelModel>>(
          future: carModelsData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            
            if(snapshot.hasData){
 
                  print("HAS DATA");
                  List<CarModelModel> carModelList = snapshot.data;
                  print("Item name: " + carModelList[0].name);
                  carModelList.forEach((element) {
                    carModelsItems
                        .add("item");
                  });
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      if (value == 'None') {
                        _carModelsController.text = "";
                      } else {
                        _carModelsController.text = value;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return carModelsItems
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  );
            }else{
              print("NO DATA");
              return Text("NO data");
            }
            /*switch (snapshot.connectionState) {
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
                  carModelsItems.clear();
                  carModelsItems.add('None');
                  List<CarModelModel> carModelList = snapshot.data;
                  carModelList.forEach((element) {
                    carModelsItems
                        .add(element.name + " (" + element.engine + ")");
                  });
                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      if (value == 'None') {
                        _carModelsController.text = "";
                      } else {
                        _carModelsController.text = value;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return carModelsItems
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  );
                }
            }*/
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  String validateCarModelTextFormField(String value) {
    if (isTextFieldEmpty(value))
      return AppLocalizations.of(context)
          .translate("carModelTextFormFieldError");
    return null;
  }

  void _loadCarModelsData() {
    
      carModelsData = apiClientTest.getCarModelsFromCarBrand(Provider.of<AddCarProvider>(context, listen: false).currentBrand);
    
  }
}
