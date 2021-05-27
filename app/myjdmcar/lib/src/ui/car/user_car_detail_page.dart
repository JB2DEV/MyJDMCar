import 'package:flutter/material.dart';
import 'package:myjdmcar/api/api_client.dart';
import 'package:myjdmcar/config/icons_routes.dart';
import 'package:myjdmcar/config/internationalization/app_localizations.dart';
import 'package:myjdmcar/models/car_model.dart';
import 'package:myjdmcar/provider/user_car_provider.dart';
import 'package:myjdmcar/src/widgets/car/car_data_container.dart';
import 'package:provider/provider.dart';

class UserCarDetailPage extends StatefulWidget {
  const UserCarDetailPage({Key key}) : super(key: key);

  @override
  _UserCarDetailPageState createState() => _UserCarDetailPageState();
}

class _UserCarDetailPageState extends State<UserCarDetailPage> {
  UserCarProvider provider;
  Future data;
  ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();

    int carId = Provider.of<UserCarProvider>(context, listen: false).carId;
    data = _apiClient.getUserCarModelData(carId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            FutureBuilder<CarModelModel>(
              future: data,
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
                      CarModelModel carModel = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              _apiClient.httpHead +
                                  _apiClient.baseUrl +
                                  _apiClient.imagesUrl +
                                  _apiClient.carModelsUrl +
                                  carModel.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text(
                                  Provider.of<UserCarProvider>(context)
                                      .carModel,
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              CarDataContainer(
                                icon: appIcons['car_engine'],
                                text: carModel.engine,
                              ),
                              Expanded(child: SizedBox()),
                              CarDataContainer(
                                icon: appIcons['car_power'],
                                text: carModel.power + " HP",
                              ),
                              Expanded(child: SizedBox()),
                              CarDataContainer(
                                icon: appIcons['car_gearshift'],
                                text: carModel.transmission,
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).translate(
                                      "userCarDetailPageDescription"),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  carModel.description,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                }
                return CircularProgressIndicator();
              },
            )
          ]))
        ],
      ),
    );
  }
}
